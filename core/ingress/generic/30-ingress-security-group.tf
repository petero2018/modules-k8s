data "aws_eks_cluster" "current" {
  name = var.eks_cluster
}

resource "aws_security_group" "ingress" {
  #checkov:skip=CKV2_AWS_5:The security group is associated with the kubernetes ingress through annotations

  name        = local.load_balancer_name
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
  count = var.open_http ? 1 : 0

  description       = "Allow inbound HTTP traffic"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.cidr_blocks != null ? var.cidr_blocks : local.default_cidr_blocks[var.ingress_purpose]
  security_group_id = aws_security_group.ingress.id
}

resource "aws_security_group_rule" "allow_https" {
  description       = "Allow inbound HTTPS traffic"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.cidr_blocks != null ? var.cidr_blocks : local.default_cidr_blocks[var.ingress_purpose]
  security_group_id = aws_security_group.ingress.id
}
