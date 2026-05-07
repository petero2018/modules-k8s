data "aws_ssm_parameter" "parameters" {
  for_each = toset(var.aws_service == "ParameterStore" ? [for parameter in var.secrets : parameter] : [])

  name = each.key
}

data "aws_secretsmanager_secret" "secrets" {
  for_each = toset(var.aws_service == "SecretsManager" ? [for secret in var.secrets : secret] : [])

  name = each.key
}

data "aws_region" "current" {}
