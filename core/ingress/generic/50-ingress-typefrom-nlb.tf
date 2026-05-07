resource "kubernetes_service" "nlb" {
  count = var.ingress_type == "powise-nlb" ? 1 : 0

  metadata {
    name      = "nlb-${var.ingress_name}-${var.ingress_purpose}"
    namespace = var.namespace

    labels = local.labels

    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-name"                              = local.load_balancer_name
      "service.beta.kubernetes.io/aws-load-balancer-type"                              = "external"
      "service.beta.kubernetes.io/aws-load-balancer-scheme"                            = "internal"
      "service.beta.kubernetes.io/aws-load-balancer-backend-protocol"                  = "ssl"
      "service.beta.kubernetes.io/aws-load-balancer-nlb-target-type"                   = "ip"
      "service.beta.kubernetes.io/aws-load-balancer-cross-zone-load-balancing-enabled" = "true"
      "service.beta.kubernetes.io/aws-load-balancer-ssl-cert"                          = var.acm_certificate_arn != null ? var.acm_certificate_arn : module.certificate[0].arn
      "service.beta.kubernetes.io/aws-load-balancer-ssl-ports"                         = "https"
      "service.beta.kubernetes.io/aws-load-balancer-ssl-negotiation-policy"            = "ELBSecurityPolicy-TLS-1-2-2017-01"
      "service.beta.kubernetes.io/aws-load-balancer-target-group-attributes"           = "deregistration_delay.timeout_seconds=180"
      "service.beta.kubernetes.io/aws-load-balancer-additional-resource-tags"          = "EksCluster=${var.eks_cluster},Role=IngressGateway,environment-type=${var.environment_type}"
    }
  }

  spec {
    selector = {
      app = local.service_name
    }

    load_balancer_source_ranges = ["172.16.0.0/12"]

    port {
      name        = "http"
      port        = 80
      target_port = var.backend_service_ports.http
    }

    port {
      name        = "https"
      port        = 443
      target_port = var.backend_service_ports.https
    }

    type = "LoadBalancer"
  }
}
