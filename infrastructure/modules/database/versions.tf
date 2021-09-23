terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.57"
    }

    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "~> 1.14"
    }
  }
}
