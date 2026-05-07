module "irsa" {
  source = "git@github.com:powise/terraform-modules//eks/irsa?ref=eks-irsa-2.1.0"

  eks_clusters = [var.eks_cluster]

  namespace        = var.namespace
  service_accounts = [local.name]
  iam_role_name    = "${local.name}-${var.eks_cluster}-${var.aws_region}"
  iam_role_path    = var.iam_role_path

  tags = local.tags
}
