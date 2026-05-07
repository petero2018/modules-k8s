data "aws_ssm_parameter" "access_token" {
  name = var.access_token_ssm_path
}
