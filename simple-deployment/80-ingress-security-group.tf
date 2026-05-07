resource "aws_security_group" "ingress" {
  count = var.ingress.enabled ? 1 : 0

  name        = "ingress-${local.instance}"
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

resource "aws_security_group_rule" "allow_http" {
  count = var.ingress.enabled ? 1 : 0

  description       = "Allow inbound HTTP traffic"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.ingress.allow_cidr_blocks
  security_group_id = aws_security_group.ingress[0].id
}

resource "aws_security_group_rule" "allow_https" {
  count = var.ingress.enabled ? 1 : 0

  description       = "Allow inbound HTTPS traffic"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.ingress.allow_cidr_blocks
  security_group_id = aws_security_group.ingress[0].id
}
