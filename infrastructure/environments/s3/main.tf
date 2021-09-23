provider "aws" {
  region = var.region
}

module "testbed" {
  source = "../../modules/testbed"

  name = "s3"

  parent_zone_id = var.parent_zone_id

  executor_key_name = var.executor_key_name

  eks_kubeconfig_aws_authenticator_env_variables = var.eks_kubeconfig_aws_authenticator_env_variables
}

provider "kubernetes" {
  host                   = module.testbed.kubernetes_endpoint
  cluster_ca_certificate = base64decode(module.testbed.kubernetes_ca)
  token                  = module.testbed.kubernetes_token
}

provider "k8s" {
  host                   = module.testbed.kubernetes_endpoint
  cluster_ca_certificate = base64decode(module.testbed.kubernetes_ca)
  token                  = module.testbed.kubernetes_token
  load_config_file       = false
}

resource "aws_s3_bucket" "this" {
  bucket        = module.testbed.name
  force_destroy = true
}

# https://docs.docker.com/registry/storage-drivers/s3/#s3-permission-scopes
resource "aws_iam_policy" "s3" {
  name = "${module.testbed.name}-s3"

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
        "${aws_s3_bucket.this.arn}"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "${aws_s3_bucket.this.arn}/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_user" "s3" {
  name = "${module.testbed.name}-s3"
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
    namespace = module.testbed.harbor_namespace
  }

  data = {
    secret = aws_iam_access_key.s3.secret
  }
}

resource "k8s_manifest" "harbor" {
  content = templatefile("${path.module}/templates/harborcluster.tpl", {
    harbor_version    = "2.3.2"
    admin_secret      = module.testbed.harbor_admin_secret
    core_domain       = module.testbed.harbor_domain
    base_domain       = module.testbed.domain
    cert_secret       = module.testbed.harbor_cert_secret
    database_host     = module.testbed.harbor_database_host
    database_port     = module.testbed.harbor_database_port
    database_username = module.testbed.harbor_database_username
    database_secret   = module.testbed.harbor_database_secret
    cache_host        = module.testbed.harbor_cache_host
    cache_port        = module.testbed.harbor_cache_port
    cache_secret      = module.testbed.harbor_cache_secret
    s3_access_key     = aws_iam_access_key.s3.id
    s3_secret         = kubernetes_secret.s3.metadata.0.name
    s3_region         = var.region
    s3_bucket         = aws_s3_bucket.this.bucket
  })
  namespace = module.testbed.harbor_namespace

  depends_on = [
    module.testbed
  ]
}
