data "aws_iam_policy_document" "s3_access" {
  count = var.s3_output_enabled ? 1 : 0

  statement {
    sid       = "AllowPutLogs"
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${var.s3_bucket}/${var.s3_key_prefix}/*"]
  }
}

module "irsa" {
  source = "../../eks/irsa"

  eks_clusters = [var.eks_cluster]

  namespace        = var.namespace
  service_accounts = ["fluentbit"]
  iam_role_name    = "${var.eks_cluster}-fluentbit-${var.aws_region}"

  iam_policy_documents = merge(
    var.s3_output_enabled ? {
      s3 = data.aws_iam_policy_document.s3_access[0].json
  } : {})

  tags = var.tags
}
