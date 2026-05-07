locals {
  default_backend_name = "unauthorized"
  basic_auth_token     = var.basic_auth_ingress.enabled ? base64encode("${random_string.basic_auth_user[0].result}:${random_password.basic_auth_password[0].result}") : null
}

resource "random_string" "basic_auth_user" {
  count = var.basic_auth_ingress.enabled ? 1 : 0

  length  = 32
  special = false # Having special characters can mess with URL encoding when using user:password@url
}

resource "random_password" "basic_auth_password" {
  count = var.basic_auth_ingress.enabled ? 1 : 0

  length  = 32
  special = false # Having special characters can mess with URL encoding when using user:password@url
}

resource "kubernetes_ingress_v1" "basic_auth" {
  count = var.basic_auth_ingress.enabled ? 1 : 0

  metadata {
    name      = "basic-auth-${var.name}"
    namespace = local.namespace

    labels = local.labels

    annotations = {
      "kubernetes.io/ingress.class" = "alb"

      "alb.ingress.kubernetes.io/scheme"                   = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"              = "ip"
      "alb.ingress.kubernetes.io/backend-protocol"         = var.backend_https ? "HTTPS" : "HTTP"
      "alb.ingress.kubernetes.io/healthcheck-protocol"     = var.backend_https ? "HTTPS" : "HTTP"
      "alb.ingress.kubernetes.io/healthcheck-path"         = var.basic_auth_ingress.healthcheck_path
      "alb.ingress.kubernetes.io/security-groups"          = "${join(",", data.aws_eks_cluster.current.vpc_config[0].security_group_ids)},${aws_security_group.basic_auth_ingress[0].id}"
      "alb.ingress.kubernetes.io/certificate-arn"          = join(",", var.basic_auth_ingress.certificate_arns)
      "alb.ingress.kubernetes.io/listen-ports"             = "[{\"HTTPS\":443}]" # Don't open HTTP on purpose, so basic auth credentials never leak unencrypted
      "alb.ingress.kubernetes.io/load-balancer-attributes" = length(local.load_balancer_attributes) == 0 ? null : join(",", local.load_balancer_attributes)
      "alb.ingress.kubernetes.io/subnets"                  = var.public_subnet_tags == null ? null : join(",", data.aws_subnets.public[0].ids)

      # 401 Unauthorized is the ALB default
      ("alb.ingress.kubernetes.io/actions.${local.default_backend_name}") = jsonencode({
        type = "fixed-response"
        fixedResponseConfig = {
          contentType = "text/plain"
          statusCode  = "401"
          messageBody = "401 Unauthorized"
        }
      })

      # Forward to backend service if header is matching
      ("alb.ingress.kubernetes.io/conditions.${kubernetes_service.app[0].metadata[0].name}") = jsonencode(
        [
          {
            field = "http-header"
            httpHeaderConfig = {
              httpHeaderName = "Authorization"
              values         = ["Basic ${local.basic_auth_token}"]
            }
          }
        ]
      )

      "external-dns.alpha.kubernetes.io/hostname" = var.basic_auth_ingress.fqdn
    }
  }

  spec {
    default_backend {
      service {
        name = local.default_backend_name
        port {
          name = "use-annotation"
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
