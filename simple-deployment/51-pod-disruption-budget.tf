resource "kubernetes_pod_disruption_budget_v1" "app" {
  metadata {
    name      = "${var.name}-pdb"
    namespace = var.namespace
  }
  spec {
    min_available   = var.disruption_setting.min_available
    max_unavailable = var.disruption_setting.max_unavailable
    selector {
      match_labels = {
        app = var.name
      }
    }
  }
}
