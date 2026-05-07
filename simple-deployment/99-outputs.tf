output "iam_role_name" {
  value = var.create_iam_role ? aws_iam_role.app[0].name : null

  description = "Name of the role assumed by containers."
}

output "iam_role_arn" {
  value = var.create_iam_role ? aws_iam_role.app[0].arn : null

  description = "ARN of the role assumed by containers."
}

output "basic_auth_username" {
  value       = var.basic_auth_ingress.enabled ? random_string.basic_auth_user[0].result : null
  sensitive   = true
  description = "Basic authentication username, if enabled."
}

output "basic_auth_password" {
  value       = var.basic_auth_ingress.enabled ? random_password.basic_auth_password[0].result : null
  sensitive   = true
  description = "Basic authentication password, if enabled."
}

output "basic_auth_token" {
  value       = var.basic_auth_ingress.enabled ? local.basic_auth_token : null
  sensitive   = true
  description = "Basic authentication token (base64 encoded 'username:password'), if enabled."
}
