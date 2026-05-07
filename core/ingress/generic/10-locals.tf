locals {
  labels = {
    "ingress-name"     = var.ingress_name
    "environment-type" = var.environment_type
  }

  load_balancer_name = substr("${var.eks_cluster}-${substr(var.ingress_purpose, 0, 1)}-${var.ingress_name}", 0, 32)

  default_cidr_blocks = {
    "public" = ["0.0.0.0/0"]
    "restricted" = concat(
      module.ips.vpn_nat_gw_ips,
      module.ips.powise_tools_eks_natgw_ips,
    )
    "internal" = ["172.16.0.0/12"]
    "wildcard" = ["0.0.0.0/0"]
  }

  service_name = var.backend_service_name == null ? "proxy-${var.ingress_purpose}" : var.backend_service_name
}
