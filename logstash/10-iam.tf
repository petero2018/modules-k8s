module "irsa" {
  count  = var.enable_iam ? 1 : 0
  source = "../../eks/irsa"

  eks_clusters = [var.eks_cluster]

  iam_role_name    = join("-", compact([var.iam_prefix, var.eks_cluster, var.iam_suffix]))
  namespace        = var.create_namespace ? module.namespace[0].namespace : var.namespace
  service_accounts = [var.name]

  iam_policy_documents = merge({
    "es_http_actions" = data.aws_iam_policy_document.role_policy[0].json
  }, var.extra_iam_policies)

  tags = var.tags
}

data "aws_iam_policy_document" "role_policy" {
  count = var.enable_iam ? 1 : 0
  statement {
    effect = "Allow"

    actions = [
      "es:ESHttpGet",
      "es:ESHttpHead",
      "es:ESHttpPatch",
      "es:ESHttpPost",
      "es:ESHttpPut",
    ]

    resources = var.opensearch_arns
  }
}
