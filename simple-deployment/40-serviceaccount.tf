resource "kubernetes_service_account" "app" {
  metadata {
    name      = var.name
    namespace = local.namespace

    labels = local.labels

    annotations = {
      "eks.amazonaws.com/role-arn" = var.create_iam_role ? aws_iam_role.app[0].arn : var.iam_role_name
    }
  }

  lifecycle {
    precondition {
      condition = anytrue([
        var.create_iam_role,
        !var.create_iam_role && can(regex("^arn:aws:iam::[0-9]{12}:role/.+$", var.iam_role_name))
      ])
      error_message = "If using an external IAM role, it must be provided as a full ARN."
    }
  }
}
