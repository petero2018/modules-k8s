resource "kubernetes_ingress_v1" "oidc" {
  count = var.oidc_ingress.enabled ? 1 : 0

  metadata {
    name      = "oidc-${var.name}"
    namespace = local.namespace

    labels = local.labels

    annotations = {
      "kubernetes.io/ingress.class" = "alb"

      "alb.ingress.kubernetes.io/scheme"               = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"          = "ip"
      "alb.ingress.kubernetes.io/backend-protocol"     = var.backend_https ? "HTTPS" : "HTTP"
      "alb.ingress.kubernetes.io/healthcheck-protocol" = var.backend_https ? "HTTPS" : "HTTP"
      "alb.ingress.kubernetes.io/healthcheck-path"     = var.oidc_ingress.healthcheck_path
      "alb.ingress.kubernetes.io/security-groups"      = "${join(",", data.aws_eks_cluster.current.vpc_config[0].security_group_ids)},${aws_security_group.oidc_ingress[0].id}"
      "alb.ingress.kubernetes.io/certificate-arn"      = join(",", var.oidc_ingress.certificate_arns)
      "alb.ingress.kubernetes.io/listen-ports"         = "[{\"HTTP\": 80}, {\"HTTPS\":443}]"
      "alb.ingress.kubernetes.io/ssl-redirect"         = "443"
      "alb.ingress.kubernetes.io/auth-type"            = "oidc"
      "alb.ingress.kubernetes.io/auth-idp-oidc" = jsonencode({
        "issuer"                = var.oidc_ingress.issuer,
        "authorizationEndpoint" = var.oidc_ingress.authorize_endpoint,
        "tokenEndpoint"         = var.oidc_ingress.token_endpoint,
        "userInfoEndpoint"      = var.oidc_ingress.userinfo_endpoint,
        "secretName"            = kubernetes_secret.oidc[0].metadata[0].name,
      })
      "alb.ingress.kubernetes.io/auth-on-unauthenticated-request" = "authenticate"
      "alb.ingress.kubernetes.io/actions.ssl-redirect"            = "{\"Type\": \"redirect\", \"RedirectConfig\": { \"Protocol\": \"HTTPS\", \"Port\": \"443\", \"StatusCode\": \"HTTP_301\"}}"
      "alb.ingress.kubernetes.io/load-balancer-attributes"        = length(local.load_balancer_attributes) == 0 ? null : join(",", local.load_balancer_attributes)
      "alb.ingress.kubernetes.io/subnets"                         = var.public_subnet_tags == null ? null : join(",", data.aws_subnets.public[0].ids)

      "external-dns.alpha.kubernetes.io/hostname" = var.oidc_ingress.fqdn
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

#This is specific to OIDC ingress as it needs to explicitly allow AWS Load Balancer Controller to read the secret:
# https://www.reddit.com/r/aws/comments/11ggibi/aws_k8s_load_balancer_controller_cant_read_oidc/
resource "kubernetes_role" "oidc_ingress" {
  count = var.oidc_ingress.enabled ? 1 : 0

  metadata {
    name      = "${var.name}-oidc"
    namespace = local.namespace
    labels    = local.labels
  }

  rule {
    api_groups     = [""]
    resources      = ["secrets"]
    resource_names = ["${var.name}-oidc"]
    verbs          = ["get", "list", "watch"]
  }
}

resource "kubernetes_role_binding" "oidc_ingress" {
  count = var.oidc_ingress.enabled ? 1 : 0

  metadata {
    name      = "${var.name}-oidc"
    namespace = local.namespace
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.oidc_ingress[0].metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
  }
}
