terraform {
  required_version = ">= 1.3.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }

    external = {
      source  = "hashicorp/external"
      version = ">= 2.1.0"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.19.0"
    }
  }
}
