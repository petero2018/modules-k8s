locals {
  # Secret Store
  secret_store_name = coalesce(var.secret_store_name, var.name)
}

module "secret_store" {
  source = "../external-secrets-aws-store"

  count = var.create_secret_store ? 1 : 0

  name      = local.secret_store_name
  namespace = var.namespace

  create_irsa     = var.create_irsa
  eks_cluster     = var.eks_cluster
  service_account = var.service_account

  aws_service = var.aws_service
  aws_region  = var.aws_region
  secrets     = [for name, secret in var.secrets : secret.key]

  wait    = var.wait
  timeout = var.timeout

  tags = var.tags
}
