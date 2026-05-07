resource "kubernetes_horizontal_pod_autoscaler_v2" "standalone" {
  metadata {
    name      = var.hpa_name
    namespace = var.namespace
  }

  spec {
    min_replicas = var.scaling.min_replicas
    max_replicas = var.scaling.max_replicas

    scale_target_ref {
      api_version = var.target.api_version
      kind        = var.target.kind
      name        = var.target.name
    }

    metric {
      type = "Resource"

      resource {
        name = var.scaling.resource_name

        target {
          type = "Utilization"

          average_utilization = var.scaling.utilization
        }
      }
    }

    behavior {
      scale_up {
        stabilization_window_seconds = 0
        select_policy                = "Max"
        policy {
          period_seconds = var.scaling.period_seconds
          type           = "Pods"
          value          = var.scaling.scale_up_pods
        }
      }

      scale_down {
        stabilization_window_seconds = var.scaling.window_seconds
        select_policy                = "Min"
        policy {
          period_seconds = var.scaling.period_seconds
          type           = "Pods"
          value          = 1
        }
      }
    }
  }
}
