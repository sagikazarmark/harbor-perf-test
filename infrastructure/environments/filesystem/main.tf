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
  })
  namespace = "harbor"

  depends_on = [
    module.testbed
  ]
}

resource "kubernetes_persistent_volume_claim" "chart" {
  metadata {
    name      = "harbor-chart"
    namespace = "harbor"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "100Gi"
      }
    }
  }

  depends_on = [
    module.testbed
  ]
}

resource "kubernetes_persistent_volume_claim" "registry" {
  metadata {
    name      = "harbor-registry"
    namespace = "harbor"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "100Gi"
      }
    }
  }

  depends_on = [
    module.testbed
  ]
}
