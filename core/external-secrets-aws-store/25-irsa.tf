module "irsa" {
  source = "../../../eks/irsa"

  count = var.create_irsa ? 1 : 0

  eks_clusters = [var.eks_cluster]

  namespace              = var.namespace
  service_account        = local.service_account
  create_service_account = true

  iam_policies_documents = {
    "secret-access" = {
      description = "Provides permissions to access secrets for ${var.name} Secret Store."
      policy      = data.aws_iam_policy_document.secret_access[0].json
    }
  }

  tags = var.tags
}
