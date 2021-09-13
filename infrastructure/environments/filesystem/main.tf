variable "region" {
  type        = string
  description = "AWS region to launch the infrastructure in"
}

provider "aws" {
  region = var.region
}

module "testbed" {
  source = "../../modules/testbed"

  name = "filesystem"

  executor_key_name = "mark"
}

output "executor_ip" {
  value = module.testbed.executor_ip
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
    harbor_version = "2.3.0"
    admin_secret   = module.testbed.harbor_admin_secret
    core_domain    = module.testbed.harbor_domain
    base_domain    = module.testbed.domain
    cert_secret    = module.testbed.harbor_cert_secret
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
