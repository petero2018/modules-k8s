resource "kubernetes_service" "caddy" {
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
      port        = 80
      target_port = 80
    }

    port {
      name        = "https"
      port        = 443
      target_port = 443
    }

    type = "ClusterIP"
  }
}
