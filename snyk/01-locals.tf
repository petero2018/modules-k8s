locals {
  name           = "snyk-monitor"
  integration_id = var.integration_ids[var.environment]
  labels = {
    "app.kubernetes.io/managed-by" = "Terraform"
    "eks-cluster"                  = var.eks_cluster
    "environment"                  = var.environment
    "app"                          = local.name
  }
}
