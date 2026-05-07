terraform {
  required_version = ">= 1.3.6"
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">=1.13.1"
    }
  }
}
