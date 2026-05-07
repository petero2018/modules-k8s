locals {
  passthrough_ingress_public_subnets  = var.public_subnet_tags == null ? null : join(",", data.aws_subnets.public[0].ids)
  passthrough_ingress_private_subnets = var.private_subnet_tags == null ? null : join(",", data.aws_subnets.private[0].ids)
}

resource "kubernetes_service" "passthrough_ingress" {
  count = var.passthrough_ingress.enabled ? 1 : 0

  metadata {
    name      = "${var.name}-passthrough-ingress"
    namespace = local.namespace

    labels = local.labels
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-name"                              = "${local.instance}-passthrough"
      "service.beta.kubernetes.io/aws-load-balancer-type"                              = "external"
      "service.beta.kubernetes.io/aws-load-balancer-scheme"                            = var.passthrough_ingress.internal ? "internal" : "internet-facing"
      "service.beta.kubernetes.io/aws-load-balancer-backend-protocol"                  = "tcp"
      "service.beta.kubernetes.io/aws-load-balancer-nlb-target-type"                   = "ip"
      "service.beta.kubernetes.io/aws-load-balancer-cross-zone-load-balancing-enabled" = "true"
      "service.beta.kubernetes.io/aws-load-balancer-target-group-attributes"           = "preserve_client_ip.enabled=true"

      "service.beta.kubernetes.io/aws-load-balancer-subnets" = var.passthrough_ingress.internal ? local.passthrough_ingress_private_subnets : local.passthrough_ingress_public_subnets

      "external-dns.alpha.kubernetes.io/hostname" = var.passthrough_ingress.fqdn
    }
  }

  spec {
    selector = local.labels

    port {
      name        = "${var.name}-passthrough-ingress"
      port        = var.passthrough_ingress.port
      target_port = var.backend_port
    }

    load_balancer_source_ranges = var.passthrough_ingress.allow_cidr_blocks

    type = "LoadBalancer"
  }
}
