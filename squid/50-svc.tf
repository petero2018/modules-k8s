resource "kubernetes_service" "squid" {
  metadata {
    name      = var.name
    namespace = var.namespace

    labels = local.labels
  }

  spec {
    selector = {
      app = var.name
    }

    port {
      name        = "http"
      port        = 3128
      target_port = 3128
    }

    type = "ClusterIP"
  }
}
