data "aws_caller_identity" "current" {}

data "aws_iam_role" "worker_role" {
  for_each = toset(var.worker_role_names)

  name = each.key
}
