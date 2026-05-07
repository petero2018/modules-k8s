resource "aws_iam_instance_profile" "karpenter" {
  name = join("-", compact(["KarpenterNodeInstanceProfile", var.eks_cluster, var.iam_suffix]))
  role = var.worker_role_name

  tags = local.tags
}
