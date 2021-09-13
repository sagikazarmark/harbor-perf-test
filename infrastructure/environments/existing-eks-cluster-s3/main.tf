locals {
  name = "harbor-test-${var.name}-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

provider "aws" {
  region = var.region
}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_id
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
  source = "../../modules/ingress"

  count = var.enable_ingress ? 1 : 0
}

module "external_dns" {
  source = "../../modules/external-dns"

  name           = local.name
  parent_zone_id = var.parent_zone_id
}

module "cert_manager" {
  source = "../../modules/cert-manager"
}

module "harbor_operator" {
  source = "../../modules/harbor-operator"

  depends_on = [
    module.cert_manager
  ]
}

module "harbor" {
  source = "../../modules/harbor"

  base_domain    = module.external_dns.domain
  cluster_issuer = module.cert_manager.cluster_issuer

  depends_on = [
    module.cert_manager,
    module.harbor_operator
  ]
}

resource "aws_s3_bucket" "s3" {
  bucket        = local.name
  force_destroy = true
}

# https://docs.docker.com/registry/storage-drivers/s3/#s3-permission-scopes
resource "aws_iam_policy" "s3" {
  name = "${local.name}-s3"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetBucketLocation",
        "s3:ListBucketMultipartUploads"
      ],
      "Resource": [
        "${aws_s3_bucket.s3.arn}"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "${aws_s3_bucket.s3.arn}/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_user" "s3" {
  name = "${local.name}-s3"
}

resource "aws_iam_user_policy_attachment" "s3" {
  user       = aws_iam_user.s3.name
  policy_arn = aws_iam_policy.s3.arn
}

resource "aws_iam_access_key" "s3" {
  user = aws_iam_user.s3.name
}

resource "kubernetes_secret" "s3" {
  metadata {
    name      = "s3"
    namespace = module.harbor.namespace
  }

  data = {
    secret = aws_iam_access_key.s3.secret
  }
}

data "aws_region" "current" {}

resource "k8s_manifest" "harbor" {
  namespace = module.harbor.namespace

  content = templatefile("${path.module}/templates/harborcluster.tpl", {
    harbor_version = "2.3.2"
    admin_secret   = module.harbor.admin_password_secret
    core_domain    = "core.${module.external_dns.domain}"
    base_domain    = module.external_dns.domain
    cert_secret    = module.harbor.cert_secret
    s3_access_key  = aws_iam_access_key.s3.id
    s3_secret      = kubernetes_secret.s3.metadata.0.name
    s3_region      = data.aws_region.current.name
    s3_bucket      = aws_s3_bucket.s3.bucket
  })
}

resource "aws_subnet" "executor" {
  vpc_id                  = data.aws_eks_cluster.cluster.vpc_config.0.vpc_id
  cidr_block              = var.executor_subnet_range
  map_public_ip_on_launch = true
}

resource "aws_route_table_association" "executor" {
  subnet_id      = aws_subnet.executor.id
  route_table_id = var.executor_route_table_id
}

module "executor" {
  source = "../../modules/executor"

  name = local.name

  vpc_id    = data.aws_eks_cluster.cluster.vpc_config.0.vpc_id
  subnet_id = aws_subnet.executor.id
  key_name  = var.executor_key_name

  harbor_host     = "core.${module.external_dns.domain}"
  harbor_password = module.harbor.admin_password
}

output "name" {
  value = local.name
}

output "executor_ip" {
  value = module.executor.public_ip
}
