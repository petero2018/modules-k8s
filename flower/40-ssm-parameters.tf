resource "aws_ssm_parameter" "videoask_flower_oauth2_key" {
  name   = "/${var.eks_cluster}/service/flower/oauth2_key"
  type   = "SecureString"
  value  = var.flower_oauth2_key
  key_id = var.kms_key_id
  tags = {
    env     = var.environment
    service = "flower"
    team    = var.tags.team
    impact  = "low"
  }
}

resource "aws_ssm_parameter" "videoask_flower_oauth2_secret" {
  name   = "/${var.eks_cluster}/service/flower/oauth2_secret"
  type   = "SecureString"
  value  = var.flower_oauth2_secret
  key_id = var.kms_key_id
  tags = {
    env     = var.environment
    service = "flower"
    team    = var.tags.team
    impact  = "low"
  }
}
