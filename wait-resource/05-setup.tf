terraform {
  required_version = ">= 0.13.7"
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = ">=3.1.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">=3.0"
    }
  }
}
