output "helm_config" {
  value       = module.helm_release.helm_config
  description = "Helm Config to be used by GitOps tools."
}

output "irsa_iam_role_arn" {
  description = "IAM role ARN for your service account"
  value       = var.create_irsa ? module.irsa[0].irsa_iam_role_arn : null
}

output "irsa_iam_role_name" {
  description = "IAM role name for your service account"
  value       = var.create_irsa ? module.irsa[0].irsa_iam_role_name : null
}
