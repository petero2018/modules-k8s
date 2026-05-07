terraform {
  required_version = ">= 1.2.4"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.8.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
}

data "aws_subnets" "public" {
  count = var.public_subnet_tags == null ? 0 : 1

  filter {
    name   = "vpc-id"
    values = [data.aws_eks_cluster.current.vpc_config[0].vpc_id]
  }

  tags = var.public_subnet_tags
}

data "aws_subnets" "private" {
  count = var.private_subnet_tags == null ? 0 : 1

  filter {
    name   = "vpc-id"
    values = [data.aws_eks_cluster.current.vpc_config[0].vpc_id]
  }

  tags = var.private_subnet_tags
}
