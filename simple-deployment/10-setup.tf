terraform {
  required_version = ">= 1.6.6"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2"
    }

    aws = {
      source  = "hashicorp/aws"
      version = ">= 3"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.5"
    }
  }
}

data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "current" {
  name = var.eks_cluster
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

locals {
  instance = "${var.environment}-${var.name}"

  aws_account_id    = data.aws_caller_identity.current.account_id
  aws_region_suffix = try(length(var.aws_region), 0) > 0 ? "-${var.aws_region}" : ""
  sa_iam_role       = length(var.iam_role_name) == 0 ? "eks-sa-${var.name}-${var.eks_cluster}${local.aws_region_suffix}" : var.iam_role_name

  oidc_issuer    = data.aws_eks_cluster.current.identity[0].oidc[0].issuer
  oidc_host_path = replace(local.oidc_issuer, "https://", "")

  ssm_secrets_path = var.ssm_secrets_path == "" ? "/${var.environment}/secrets/${var.name}" : var.ssm_secrets_path

  # has NO "app.kubernetes.io/version" label, to avoid unnecessary updates & replacements
  labels = merge(
    {
      "app.kubernetes.io/name"       = var.name
      "app.kubernetes.io/instance"   = local.instance
      "app.kubernetes.io/managed-by" = "Terraform"
      "environment"                  = var.environment
      "app"                          = var.name
    },
  var.add_cluster_label ? { "eks-cluster" = var.eks_cluster } : {})


  # has "app.kubernetes.io/version" label, relevant to deployment objects
  deployment_labels = merge(
    {
      "app.kubernetes.io/name"       = var.name
      "app.kubernetes.io/instance"   = local.instance
      "app.kubernetes.io/version"    = var.app_image_tag
      "app.kubernetes.io/managed-by" = "Terraform"
      "environment"                  = var.environment
      "app"                          = var.name
    },
  var.add_cluster_label ? { "eks-cluster" = var.eks_cluster } : {})

  dind            = var.enable_dind ? { "dind" : "docker:20.10.1-dind" } : {}
  redis           = var.enable_redis ? { "redis" : "redis:6.0.9" } : {}
  statsd_exporter = var.enable_statsd_exporter ? { "statsd-exporter" : "567716553783.dkr.ecr.us-east-1.amazonaws.com/mirror/prom/statsd-exporter:v0.23.1" } : {}

  load_balancer_attributes = sort([for k, v in var.load_balancer_attributes : "${k}=${v}"])

  base_tolerations = var.arch_selection ? [{
    key      = "architecture",
    value    = var.deploy_arch,
    operator = "Equal"
    effect   = "NoExecute",
  }] : []
  tolerations = concat(local.base_tolerations, var.tolerations)
}
