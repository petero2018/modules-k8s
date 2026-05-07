terraform {
  required_version = ">= 1.6.6"

  required_providers {
    kubectl = {
      source  = "alekc/kubectl"
      version = ">= 2.0"
    }
  }
}
