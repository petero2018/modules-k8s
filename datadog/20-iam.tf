data "aws_iam_policy_document" "opensearch_read_policy" {
  count = length(var.opensearch_arns) > 0 ? 1 : 0

  version = "2012-10-17"

  statement {
    effect = "Allow"

    actions = [
      "es:ESHttpHead",
      "es:ESHttpGet"
    ]

    resources = formatlist("%s/*", var.opensearch_arns)
  }
}

module "agent_role" {
  source = "../../eks/irsa"

  eks_clusters = [var.eks_cluster]

  iam_role_name    = join("-", ["datadog", var.eks_cluster, var.region])
  namespace        = var.namespace
  service_accounts = ["datadog"]

  iam_policy_arns = concat(
    [
      "arn:aws:iam::aws:policy/AmazonMSKReadOnlyAccess", # Necessary for MSK monitoring
    ],
    var.agent_iam_policy_arns
  )

  iam_policy_documents = length(var.opensearch_arns) > 0 ? {
    "OpenSearchMonitoring" = data.aws_iam_policy_document.opensearch_read_policy[0].json
  } : {}

  tags = var.tags
}
