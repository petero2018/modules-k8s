terraform {
  required_version = ">= 0.13.7"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.7.1"
    }

    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
}
