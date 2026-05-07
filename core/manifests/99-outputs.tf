output "eks_cluster" {
  value       = var.eks_cluster
  description = "Name of the EKS cluster to deploy into."
}

output "environment" {
  value       = var.environment
  description = "Deploy environment."
}
