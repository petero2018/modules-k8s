data "aws_iam_policy_document" "argocd_assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "AWS"
      identifiers = [
        var.auth_iam_role_arn
      ]
    }
  }
}

resource "aws_iam_role" "argocd_remote_role" {
  name = join("-", compact(["ArgoCDRole", var.create_suffixed_role ? var.cluster_name : ""]))

  assume_role_policy = data.aws_iam_policy_document.argocd_assume_role_policy.json

  tags = var.tags

  provider = aws.remote
}
