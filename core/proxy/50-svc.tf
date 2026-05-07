resource "kubernetes_service" "haproxy" {
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
      target_port = 8080
    }

    port {
      name        = "https"
      port        = 443
      target_port = 8443
    }

    type = "ClusterIP"
  }
}
