resource "kubernetes_ingress_v1" "internal" {
  count = var.internal_ingress.enabled ? 1 : 0

  metadata {
    name      = "internal-${var.name}"
    namespace = local.namespace

    labels = local.labels

    annotations = {
      "kubernetes.io/ingress.class" = "alb"

      "alb.ingress.kubernetes.io/scheme"                   = "internal"
      "alb.ingress.kubernetes.io/target-type"              = "ip"
      "alb.ingress.kubernetes.io/backend-protocol"         = var.backend_https ? "HTTPS" : "HTTP"
      "alb.ingress.kubernetes.io/healthcheck-protocol"     = var.backend_https ? "HTTPS" : "HTTP"
      "alb.ingress.kubernetes.io/healthcheck-path"         = var.internal_ingress.healthcheck_path
      "alb.ingress.kubernetes.io/security-groups"          = "${join(",", data.aws_eks_cluster.current.vpc_config[0].security_group_ids)},${aws_security_group.internal_ingress[0].id}"
      "alb.ingress.kubernetes.io/certificate-arn"          = join(",", var.internal_ingress.certificate_arns)
      "alb.ingress.kubernetes.io/listen-ports"             = "[{\"HTTP\": 80}, {\"HTTPS\":443}]"
      "alb.ingress.kubernetes.io/ssl-redirect"             = "443"
      "alb.ingress.kubernetes.io/actions.ssl-redirect"     = "{\"Type\": \"redirect\", \"RedirectConfig\": { \"Protocol\": \"HTTPS\", \"Port\": \"443\", \"StatusCode\": \"HTTP_301\"}}"
      "alb.ingress.kubernetes.io/load-balancer-attributes" = length(local.load_balancer_attributes) == 0 ? null : join(",", local.load_balancer_attributes)
      "alb.ingress.kubernetes.io/subnets"                  = var.private_subnet_tags == null ? null : join(",", data.aws_subnets.private[0].ids)

      "external-dns.alpha.kubernetes.io/hostname" = var.internal_ingress.fqdn
    }
  }

  spec {
    default_backend {
      service {
        name = kubernetes_service.app[0].metadata[0].name
        port {
          number = var.backend_port
        }
      }
    }

    rule {
      http {
        path {
          backend {
            service {
              name = kubernetes_service.app[0].metadata[0].name
              port {
                number = var.backend_port
              }
            }
          }

          path = "/*"
        }
      }
    }
  }

  lifecycle {
    precondition {
      condition     = local.valid_ingress_configuration
      error_message = local.valid_ingress_precondition_error_message
    }
  }
}
