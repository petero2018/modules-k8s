module "irsa" {
  source = "git@github.com:powise/terraform-modules//eks/irsa?ref=eks-irsa-1.2.1"

  eks_clusters = [var.eks_cluster]

  namespace       = var.namespace
  service_account = local.name
  iam_role_name   = length(var.aws_region) > 0 ? "${local.name}-${var.eks_cluster}-${var.aws_region}" : "${local.name}-${var.eks_cluster}"

  iam_policies_documents = {
    "velero-backups" = {
      description = "Allows read and write to backup bucket"
      policy      = data.aws_iam_policy_document.velero_backups.json
    }
  }

  tags = local.tags
}
