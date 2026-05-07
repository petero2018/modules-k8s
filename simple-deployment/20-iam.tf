resource "aws_iam_role" "app" {
  count = var.create_iam_role ? 1 : 0

  name = local.sa_iam_role

  assume_role_policy = data.aws_iam_policy_document.app[0].json

  tags = merge(
    local.labels,
    var.tags
  )
}

data "aws_iam_policy_document" "app" {
  count = var.create_iam_role ? 1 : 0

  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${local.aws_account_id}:oidc-provider/${local.oidc_host_path}"]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "${local.oidc_host_path}:sub"
      values   = ["system:serviceaccount:${local.namespace}:${var.name}"]
    }
  }
}

data "aws_iam_policy_document" "extra_policy" {
  count = var.create_iam_role && length(var.extra_policy_statements) > 0 ? 1 : 0

  dynamic "statement" {
    for_each = var.extra_policy_statements

    content {
      effect    = statement.value["effect"]
      actions   = statement.value["actions"]
      resources = statement.value["resources"]
    }
  }
}

resource "aws_iam_policy" "extra_policy" {
  count = var.create_iam_role && length(var.extra_policy_statements) > 0 ? 1 : 0

  name   = "${local.instance}-extra-policy"
  policy = data.aws_iam_policy_document.extra_policy[0].json

  tags = {
    Env     = var.environment
    Service = var.tags.service
    Team    = var.tags.team
    Impact  = var.tags.impact
  }
}

resource "aws_iam_role_policy_attachment" "extra_policy_attach" {
  count = var.create_iam_role && length(var.extra_policy_statements) > 0 ? 1 : 0

  role       = aws_iam_role.app[0].name
  policy_arn = aws_iam_policy.extra_policy[0].arn
}

moved {
  from = aws_iam_role.app
  to   = aws_iam_role.app[0]
}
