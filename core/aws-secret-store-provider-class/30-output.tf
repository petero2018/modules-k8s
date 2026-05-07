output "iam_policy" {
  value       = var.generate_iam_policy ? data.aws_iam_policy_document.secret_access[0].json : ""
  description = "IAM Policy to get secrets defined in this secret store."
}
