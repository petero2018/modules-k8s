module "vpc_cni_irsa" {
  source = "../../../eks/irsa"

  eks_clusters = [var.eks_cluster]

  namespace = "kube-system"

  service_account        = "aws-node"
  iam_role_name          = "${var.eks_cluster}-aws-node"
  create_service_account = false

  iam_policies = [
    "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonEKS_CNI_Policy"
  ]

  tags = local.tags
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name = var.eks_cluster
  addon_name   = "vpc-cni"

  addon_version = var.vpc_cni_version

  resolve_conflicts = "OVERWRITE"

  service_account_role_arn = module.vpc_cni_irsa.irsa_iam_role_arn

  tags = local.tags

  lifecycle {
    ignore_changes = [
      modified_at
    ]
  }

  depends_on = [module.vpc_cni_irsa]
}
