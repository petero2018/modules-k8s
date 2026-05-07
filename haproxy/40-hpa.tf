resource "kubernetes_horizontal_pod_autoscaler" "haproxy" {
  metadata {
    name      = var.name
    namespace = var.namespace

    labels = local.labels
  }

  spec {
    min_replicas = var.min_replicas
    max_replicas = var.max_replicas

    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = kubernetes_deployment.haproxy.metadata[0].name
    }

    metric {
      type = "Resource"

      resource {
        name = "cpu"

        target {
          type = "Utilization"

          average_utilization = 60
        }
      }
    }

    behavior {
      scale_up {
        stabilization_window_seconds = 0
        select_policy                = "Max"
        policy {
          period_seconds = 120
          type           = "Pods"
          value          = 1
        }
      }
      scale_down {
        stabilization_window_seconds = 300
        select_policy                = "Min"
        policy {
          period_seconds = 120
          type           = "Pods"
          value          = 1
        }
      }
    }
  }
}
