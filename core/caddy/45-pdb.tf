resource "kubernetes_pod_disruption_budget_v1" "caddy" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels    = local.labels
  }

  spec {
    max_unavailable = 1

    selector {
      match_labels = {
        app = var.name
      }
    }
  }
}
