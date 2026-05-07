data "aws_iam_policy_document" "secret_access" {
  count = var.create_irsa ? 1 : 0

  # Secrets manager block
  dynamic "statement" {
    for_each = length(var.secrets) > 0 && var.aws_service == "SecretsManager" ? [1] : []
    content {
      sid    = "SecretsManagerAccess"
      effect = "Allow"
      actions = [
        "secretsmanager:GetResourcePolicy",
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret",
        "secretsmanager:ListSecretVersionIds"
      ]
      resources = [for secret in var.secrets : data.aws_secretsmanager_secret.secrets[secret].arn]
    }
  }

  # Parameter store block
  dynamic "statement" {
    for_each = length(var.secrets) > 0 && var.aws_service == "ParameterStore" ? [1] : []
    content {
      sid    = "ParameterStoreAccess"
      effect = "Allow"
      actions = [
        "ssm:GetParameter",
        "ssm:GetParameters"
      ]
      resources = [for parameter in var.secrets : data.aws_ssm_parameter.parameters[parameter].arn]
    }
  }
}
