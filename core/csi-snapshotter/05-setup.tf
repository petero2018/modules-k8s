terraform {
  required_version = ">= 0.13.7"
  required_providers {
    http = {
      source  = "hashicorp/http"
      version = ">= 2.1.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.13.1"
    }
  }
}
