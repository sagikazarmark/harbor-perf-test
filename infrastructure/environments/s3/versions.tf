terraform {
  required_version = "~> 1.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.4"
    }

    k8s = {
      source  = "banzaicloud/k8s"
      version = "~> 0.9"
    }

    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "~> 1.14"
    }
  }
}
