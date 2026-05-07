data "kubernetes_namespace" "selected" {
  metadata {
    name = var.name
  }
}
