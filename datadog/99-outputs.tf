output "agent_role_arn" {
  value = module.agent_role.irsa_iam_role_arn

  description = "ARN of the Datadog agent IAM role."
}
