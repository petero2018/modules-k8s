resource "kubernetes_secret" "provisioned" {
  metadata {
    name      = local.name
    namespace = module.namespace.namespace
    labels    = local.labels
  }

  data = {
    "dockercfg.json"         = coalesce(var.dockercfg_json, "{}")
    "integrationId"          = local.integration_id
    "serviceAccountApiToken" = var.service_account_api_token
  }
}
