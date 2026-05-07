output "worker_role_names" {
  value       = [for worker_role_name in var.worker_role_names : data.aws_iam_role.worker_role[worker_role_name].id]
  description = "IAM role names for worker nodes."
}

output "worker_role_arns" {
  value       = [for worker_role_name in var.worker_role_names : data.aws_iam_role.worker_role[worker_role_name].arn]
  description = "IAM role ARNs for worker nodes."
}
