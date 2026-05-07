output "argocd_security_role_arn" {
  value       = aws_iam_role.argocd_remote_role.arn
  description = "The ARN of the IAM role created by the module."
}

output "argocd_security_role_name" {
  value       = aws_iam_role.argocd_remote_role.name
  description = "The name of the IAM role created by the module."
}
