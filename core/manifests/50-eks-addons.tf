resource "aws_eks_addon" "kube_proxy" {
  cluster_name = var.eks_cluster

  addon_name    = "kube-proxy"
  addon_version = var.kube_proxy_version

  resolve_conflicts = "OVERWRITE"

  tags = {
    Env     = var.environment
    Service = var.tags.service
    Team    = var.tags.team
    Impact  = var.tags.impact
  }
}

resource "aws_eks_addon" "vpc_cni" {
  # don't create the addon resource if there's configuration for security group policies
  # in that case the chart should be used instead
  count = var.enable_security_group_policies ? 0 : 1

  cluster_name = var.eks_cluster

  addon_name    = "vpc-cni"
  addon_version = var.vpc_cni_version

  resolve_conflicts = "OVERWRITE"

  tags = {
    Env     = var.environment
    Service = var.tags.service
    Team    = var.tags.team
    Impact  = var.tags.impact
  }
}

resource "aws_eks_addon" "core_dns" {
  cluster_name = var.eks_cluster

  addon_name    = "coredns"
  addon_version = var.coredns_version

  resolve_conflicts = "OVERWRITE"

  tags = {
    Env     = var.environment
    Service = var.tags.service
    Team    = var.tags.team
    Impact  = var.tags.impact
  }
}
