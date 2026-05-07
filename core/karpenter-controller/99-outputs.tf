output "interruption_queue_name" {
  description = "Name of the SQS queue for spot interruption handling"
  value       = var.enable_spot_termination ? aws_sqs_queue.interruption[0].name : null
}

output "interruption_queue_arn" {
  description = "ARN of the SQS queue for spot interruption handling"
  value       = var.enable_spot_termination ? aws_sqs_queue.interruption[0].arn : null
}

output "karpenter_role_arn" {
  description = "ARN of the Karpenter controller IAM role"
  value       = module.karpenter_role.irsa_iam_role_arn
}
