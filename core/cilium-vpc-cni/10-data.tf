data "aws_eks_cluster" "current" {
  name = var.eks_cluster
}

data "aws_eks_cluster_auth" "current" {
  name = var.eks_cluster
}

data "aws_partition" "current" {}
