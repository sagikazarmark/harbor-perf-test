locals {
  name = "harbor-test-${var.name}-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.7"

  name                 = local.name
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
  public_subnets       = ["10.0.5.0/24", "10.0.6.0/24", "10.0.7.0/24", "10.0.8.0/24"]
  database_subnets     = ["10.0.9.0/24", "10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.name}" = "shared"
    "kubernetes.io/role/elb"              = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.name}" = "shared"
    "kubernetes.io/role/internal-elb"     = "1"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 17.8"

  cluster_name    = local.name
  cluster_version = var.kubernetes_version

  vpc_id  = module.vpc.vpc_id
  subnets = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]

  # Auth configmap management causes trouble
  # https://github.com/terraform-aws-modules/terraform-aws-eks/issues/1536
  # https://github.com/terraform-aws-modules/terraform-aws-eks/issues/1280
  # https://github.com/terraform-aws-modules/terraform-aws-eks/issues/1487
  manage_aws_auth = false

  # Without managed auth configmap this option makes no sense
  write_kubeconfig = false

  node_groups = {
    main = {
      instance_type    = var.eks_node_instance_type
      desired_capacity = var.eks_node_group_size
      max_capacity     = var.eks_node_group_size
    },
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token

  experiments {
    manifest_resource = true
  }
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

provider "k8s" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}

resource "local_file" "kubeconfig_admin" {
  content = templatefile("${path.module}/templates/kubeconfig.tpl", {
    kubeconfig_name     = "eks_${local.name}"
    endpoint            = data.aws_eks_cluster.cluster.endpoint
    cluster_auth_base64 = data.aws_eks_cluster.cluster.certificate_authority.0.data
    token               = data.aws_eks_cluster_auth.cluster.token
  })
  filename             = "./kubeconfig_admin_${local.name}"
  file_permission      = "0600"
  directory_permission = "0755"
}

module "ingress" {
  source = "../ingress"

  chart_version = var.ingress_chart_version

  depends_on = [
    module.eks
  ]
}

module "external_dns" {
  source = "../external-dns"

  name   = local.name
  vpc_id = module.vpc.vpc_id

  chart_version = var.external_dns_chart_version

  depends_on = [
    module.eks
  ]
}

module "cert_manager" {
  source = "../cert-manager"

  chart_version = var.cert_manager_chart_version

  depends_on = [
    module.eks
  ]
}

module "harbor_operator" {
  source = "../harbor-operator"

  chart_version = var.harbor_operator_chart_version

  depends_on = [
    module.eks,
    module.cert_manager
  ]
}

module "harbor" {
  source = "../harbor"

  base_domain    = module.external_dns.domain
  cluster_issuer = module.cert_manager.cluster_issuer

  depends_on = [
    module.eks,
    module.cert_manager,
    module.harbor_operator
  ]
}

module "executor" {
  source = "../executor"

  name = local.name

  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnets[3]
  instance_type = var.executor_instance_type
  key_name      = var.executor_key_name

  harbor_host     = "core.${module.external_dns.domain}"
  harbor_password = module.harbor.admin_password
}
