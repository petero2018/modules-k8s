output "iam_role_arn" {
  value       = var.enable_iam ? module.irsa[0].irsa_iam_role_arn : null
  description = "Logstash IAM role ARN (if created)."
}
