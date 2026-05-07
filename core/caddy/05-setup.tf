terraform {
  required_version = ">= 1.3.6"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.21.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
}
