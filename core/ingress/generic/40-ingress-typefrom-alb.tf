resource "kubernetes_ingress_v1" "alb" {
  count = var.ingress_type == "powise-alb" ? 1 : 0

  metadata {
    name      = "${var.ingress_name}-${var.ingress_purpose}"
    namespace = var.namespace

    labels = local.labels

    annotations = {
      "kubernetes.io/ingress.class" = "alb"

      "alb.ingress.kubernetes.io/load-balancer-name"      = local.load_balancer_name
      "alb.ingress.kubernetes.io/scheme"                  = var.ingress_purpose == "internal" ? var.ingress_purpose : "internet-facing"
      "alb.ingress.kubernetes.io/target-type"             = "ip"
      "alb.ingress.kubernetes.io/backend-protocol"        = var.alb_config.backend_protocol
      "alb.ingress.kubernetes.io/healthcheck-protocol"    = var.alb_config.healthcheck_protocol
      "alb.ingress.kubernetes.io/healthcheck-path"        = var.alb_config.healthcheck_path
      "alb.ingress.kubernetes.io/security-groups"         = "${aws_security_group.ingress.id},${join(",", data.aws_eks_cluster.current.vpc_config[0].security_group_ids)}"
      "alb.ingress.kubernetes.io/certificate-arn"         = var.acm_certificate_arn != null ? var.acm_certificate_arn : module.certificate[0].arn
      "alb.ingress.kubernetes.io/listen-ports"            = "[{\"HTTP\": 80}, {\"HTTPS\":443}]"
      "alb.ingress.kubernetes.io/actions.ssl-redirect"    = "{\"Type\": \"redirect\", \"RedirectConfig\": { \"Protocol\": \"HTTPS\", \"Port\": \"443\", \"StatusCode\": \"HTTP_301\"}}"
      "alb.ingress.kubernetes.io/ssl-policy"              = "ELBSecurityPolicy-TLS-1-2-2017-01"
      "alb.ingress.kubernetes.io/target-group-attributes" = "deregistration_delay.timeout_seconds=180"
      "alb.ingress.kubernetes.io/tags"                    = "EksCluster=${var.eks_cluster},Role=IngressGateway,environment-type=${var.environment_type}"
      "alb.ingress.kubernetes.io/subnets"                 = var.ingress_purpose == "internal" ? join(",", data.aws_subnets.private[0].ids) : join(",", data.aws_subnets.public[0].ids)

      "external-dns.alpha.kubernetes.io/hostname" = "${var.hostname},*.${var.hostname}"
    }
  }

  spec {
    default_backend {
      service {
        name = local.service_name
        port {
          number = var.backend_service_ports.https
        }

      }
    }

    rule {
      http {
        path {
          backend {
            service {
              name = "ssl-redirect"
              port {
                name = "use-annotation"
              }
            }
          }

          path = "/*"
        }
      }
    }

    rule {
      http {
        path {
          backend {
            service {
              name = local.service_name
              port {
                number = var.backend_service_ports.https
              }
            }
          }

          path = "/*"
        }
      }
    }
  }
}
