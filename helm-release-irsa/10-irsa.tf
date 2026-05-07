module "irsa" {
  count = var.create_irsa ? 1 : 0

  source = "../../eks/irsa"

  namespace = var.namespace

  eks_clusters             = [var.eks_cluster]
  service_account          = coalesce(var.service_account, var.name)
  iam_role_name            = var.iam_role_name
  iam_role_path            = var.iam_role_path
  iam_permissions_boundary = var.iam_permissions_boundary
  iam_policy_arns          = var.iam_policy_arns
  iam_policy_documents     = var.iam_policy_documents

  tags = var.tags
}
