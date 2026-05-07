resource "kubectl_manifest" "external_secret" {
  yaml_body = yamlencode({
    apiVersion = "external-secrets.io/v1beta1"
    kind       = "ExternalSecret"
    metadata = {
      name      = var.name
      namespace = var.namespace
    }
    spec = {
      refreshInterval = var.refresh_interval
      secretStoreRef = merge({
        name = var.secret_store_name
        kind = var.secret_store_type
        }, var.secret_store_type == "SecretStore" ? {
        namespace = var.namespace
      } : {})
      target = {
        name           = coalesce(var.secret_name, var.name)
        creationPolicy = var.creation_policy
      }
      data = [
        for name, config in var.secrets : {
          secretKey = name
          remoteRef = {
            key      = config.key
            property = config.property
          }
        }
      ]
    }
  })
}
