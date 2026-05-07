terraform {
  required_version = ">= 0.13.7"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>2"
    }
  }
}
