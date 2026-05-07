resource "aws_security_group" "basic_auth_ingress" {
  #checkov:skip=CKV2_AWS_5:The security group is associated with the kubernetes ingress through annotations
  count = var.basic_auth_ingress.enabled ? 1 : 0

  name        = "basic-auth-ingress-${local.instance}"
  description = "Allow inbound HTTP and HTTPS traffic"
  vpc_id      = data.aws_eks_cluster.current.vpc_config[0].vpc_id

  egress {
    description = "Allow outbound traffic to everywhere"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.labels
}

resource "aws_security_group_rule" "allow_https_basic_auth" {
  count = var.basic_auth_ingress.enabled ? 1 : 0

  description       = "Allow inbound HTTPS traffic"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.basic_auth_ingress.allow_cidr_blocks
  security_group_id = aws_security_group.basic_auth_ingress[0].id
}
