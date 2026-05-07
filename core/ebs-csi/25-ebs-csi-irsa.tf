module "ebs_csi_irsa" {
  # https://docs.aws.amazon.com/eks/latest/userguide/csi-iam-role.html
  source = "../../../eks/irsa"

  eks_clusters = [var.eks_cluster]

  iam_role_name = length(var.aws_region) > 0 ? "${local.name}-${var.eks_cluster}-${var.aws_region}" : "${local.name}-${var.eks_cluster}"

  namespace = "kube-system"

  service_accounts = [local.name]

  iam_policy_arns = [
    "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  ]

  iam_policy_documents = local.kms_policies

  tags = local.tags
}
