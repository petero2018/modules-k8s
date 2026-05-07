data "aws_ssm_parameter" "parameters" {
  for_each = toset([for parameter in local.ssm_parameters : parameter.name])

  name = each.key
}

data "aws_secretsmanager_secret" "secrets" {
  for_each = toset([for secret in local.aws_secrets : secret.name])

  name = each.key
}
