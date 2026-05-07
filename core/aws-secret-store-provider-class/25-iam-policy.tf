data "aws_iam_policy_document" "secret_access" {
  count = var.generate_iam_policy ? 1 : 0

  # Secrets manager block
  dynamic "statement" {
    for_each = length(local.aws_secrets) > 0 ? [1] : []
    content {
      sid       = "SecretsManagerAccess"
      effect    = "Allow"
      actions   = ["secretsmanager:GetSecretValue", "secretsmanager:DescribeSecret"]
      resources = [for obj in local.aws_secrets : data.aws_secretsmanager_secret.secrets[obj.name].arn]
    }
  }

  # Parameter store block
  dynamic "statement" {
    for_each = length(local.ssm_parameters) > 0 ? [1] : []
    content {
      sid       = "ParameterStoreAccess"
      effect    = "Allow"
      actions   = ["ssm:GetParameter", "ssm:GetParameters"]
      resources = [for obj in local.ssm_parameters : data.aws_ssm_parameter.parameters[obj.name].arn]
    }
  }
}
