resource "kubernetes_service_account" "caddy" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels    = local.labels
    annotations = {
      "eks.amazonaws.com/role-arn" = var.role_arn
    }
  }
}
