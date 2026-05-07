terraform {
  required_version = ">= 1.6.6"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.16.1"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.19.0"
    }
  }
}
