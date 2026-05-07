resource "kubernetes_secret" "main" {
  for_each = var.secrets

  metadata {
    name      = each.key
    namespace = var.namespace

    labels = var.labels
  }

  data = each.value
}
