output "instance_profile_name" {
  value       = aws_iam_instance_profile.karpenter.name
  description = "Karpenter Instance Profile Name"
}

output "instance_profile_arn" {
  value       = aws_iam_instance_profile.karpenter.arn
  description = "Karpenter Instance Profile ARN"
}
