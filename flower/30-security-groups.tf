resource "aws_security_group" "flower_pods" {
  name        = "flower-celery-pods-${var.eks_cluster}"
  description = "Default security group for flower-celery pods."
  vpc_id      = var.vpc_id

  tags = {
    Name    = "flower-celery-pods"
    Env     = var.environment
    Service = "flower"
    Team    = var.tags.team
    Impact  = "low"
  }
}

resource "aws_security_group_rule" "flower_pods_egress" {
  description       = "Egress: Allow access to everywhere from flower pods."
  from_port         = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.flower_pods.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "flower_pods_ingress_from_eks_worker" {
  description              = "Ingress: Allow all ingress traffic from eks worker security group."
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.flower_pods.id
  source_security_group_id = var.workers_security_group_id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "eks_worker_ingress_from_flower_pods" {
  description              = "Ingress: Allow all ingress traffic from flower pods security group."
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = var.workers_security_group_id
  source_security_group_id = aws_security_group.flower_pods.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "redis_ingress_from_flower_pods" {
  description              = "Ingress: Allow access to redis from flower pods."
  from_port                = 6379
  protocol                 = "tcp"
  security_group_id        = var.redis_security_group_id
  source_security_group_id = aws_security_group.flower_pods.id
  to_port                  = 6379
  type                     = "ingress"
}
