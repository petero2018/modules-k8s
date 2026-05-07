resource "kubernetes_service" "app" {
  count = var.create_service ? 1 : 0

  metadata {
    name      = var.name
    namespace = local.namespace

    labels = local.labels
  }

  spec {
    selector = local.labels

    port {
      name        = var.name
      port        = var.backend_port
      target_port = var.backend_port
    }

    type = "ClusterIP"
  }
}

moved {
  from = kubernetes_service.app
  to   = kubernetes_service.app[0]
}
