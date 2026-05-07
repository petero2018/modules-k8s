terraform {
  required_version = ">= 1.3.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }

    # tflint-ignore: terraform_unused_required_providers
    helm = {
      source = "hashicorp/helm"
      # breaking changes in version 3
      version = "<3"
    }
  }
}
