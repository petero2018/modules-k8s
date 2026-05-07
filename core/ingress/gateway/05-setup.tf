terraform {
  required_version = ">= 1.6.6"
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.13.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.7.1"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~>3.1.0"
    }
  }
}
