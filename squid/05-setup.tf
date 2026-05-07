terraform {
  required_version = ">= 1.6.6"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.7.1"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">=1.13.1"
    }
  }
}
