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
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  database_subnets     = ["10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24"]
  elasticache_subnets  = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  create_database_internet_gateway_route = true
  create_database_subnet_route_table     = true

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
  subnets = module.vpc.private_subnets

  # Auth configmap management causes trouble
  # https://github.com/terraform-aws-modules/terraform-aws-eks/issues/1536
  # https://github.com/terraform-aws-modules/terraform-aws-eks/issues/1280
  # https://github.com/terraform-aws-modules/terraform-aws-eks/issues/1487
  manage_aws_auth = false

  kubeconfig_aws_authenticator_env_variables = var.eks_kubeconfig_aws_authenticator_env_variables

  node_groups = {
    test = {
      instance_types   = [var.eks_test_node_group_instance_type]
      desired_capacity = var.eks_test_node_group_size
      max_capacity     = var.eks_test_node_group_size
      taints = [
        {
          key    = "role"
          value  = "test"
          effect = "NO_SCHEDULE"
        }
      ]
      k8s_labels = {
        role = "test"
      }
    },
    infra = {
      instance_types   = [var.eks_infra_node_group_instance_type]
      desired_capacity = var.eks_infra_node_group_size
      max_capacity     = var.eks_infra_node_group_size
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

  chart_version  = var.external_dns_chart_version
  parent_zone_id = var.parent_zone_id

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

module "database" {
  source = "../database"

  name              = local.name
  vpc_id            = module.vpc.vpc_id
  subnet_group_name = module.vpc.database_subnet_group_name
  instance_type     = var.database_instance_type
  harbor_namespace  = module.harbor.namespace
}

module "cache" {
  source = "../cache"

  name              = local.name
  vpc_id            = module.vpc.vpc_id
  subnet_group_name = module.vpc.elasticache_subnet_group_name
  instance_type     = var.cache_instance_type
  security_group_id = module.eks.cluster_primary_security_group_id
  harbor_namespace  = module.harbor.namespace
}

module "executor" {
  source = "../executor"

  name = local.name

  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnets[0]
  instance_type = var.executor_instance_type
  key_name      = var.executor_key_name

  harbor_host     = "core.${module.external_dns.domain}"
  harbor_password = module.harbor.admin_password
}
