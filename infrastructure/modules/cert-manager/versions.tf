terraform {
  required_version = "~> 1.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.4"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.3"
    }

    k8s = {
      source  = "banzaicloud/k8s"
      version = "~> 0.9"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.1"
    }
  }
}
