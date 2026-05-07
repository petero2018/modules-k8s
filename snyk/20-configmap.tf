resource "kubernetes_config_map" "snyk_monitor_custom_policies" {
  metadata {
    name      = "snyk-monitor-custom-policies"
    namespace = module.namespace.namespace

    labels = local.labels
  }

  data = {
    "workload-events.rego" = templatefile("${path.module}/templates/workload-events.rego.tftpl", {
      integration_id = local.integration_id
    })
  }
}
