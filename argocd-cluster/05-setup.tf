terraform {
  required_version = ">= 0.15.5"
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">=3.0"
      configuration_aliases = [aws.remote]
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2"
    }
  }
}

# https://support.hashicorp.com/hc/en-us/articles/1500000332721-Error-Provider-configuration-not-present
provider "aws" {
  alias = "remote"
}
