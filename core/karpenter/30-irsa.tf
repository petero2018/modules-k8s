module "irsa" {
  source = "../../../eks/irsa"

  eks_clusters = [var.eks_cluster]

  namespace       = var.namespace
  service_account = local.name
  iam_role_name   = join("-", compact([var.eks_cluster, local.name, var.iam_suffix]))

  iam_policy_documents = {
    "karpenter-controller" = data.aws_iam_policy_document.karpenter_controller.json
  }

  tags = local.tags
}
