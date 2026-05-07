resource "kubernetes_secret" "datadog_secret" {
  metadata {
    name      = "datadog"
    namespace = kubernetes_namespace.flagger.metadata[0].name

    labels = local.labels
  }

  type = "Opaque"

  data = {
    "datadog_api_key"         = var.datadog_api_key
    "datadog_application_key" = var.datadog_app_key
  }
}
