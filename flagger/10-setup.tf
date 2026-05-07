locals {
  labels = {
    "app.kubernetes.io/name"       = "flagger"
    "app.kubernetes.io/managed-by" = "Terraform"
    "app"                          = "flagger"
  }
}

terraform {
  required_version = ">= 1.6.6"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.7.1"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "!= 2.4.0" # version 2.4.0 is broken as explained here: https://github.com/hashicorp/terraform-provider-helm/issues/797
    }
  }
}
