terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      # breaking changes in version 3
      version = "<3"
    }

    aws = {
      source  = "hashicorp/aws"
      version = ">=4.0"
    }
  }

  required_version = ">= 1.3.6"
}
