data "aws_ssm_parameter" "sensitive" {
  for_each = var.set_sensitive_values_from_ssm

  name = each.value
}
