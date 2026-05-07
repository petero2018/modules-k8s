resource "kubernetes_namespace" "flagger" {
  metadata {
    name = var.namespace

    labels = local.labels
  }
}
