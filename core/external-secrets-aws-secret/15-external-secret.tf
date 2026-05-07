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
      secretStoreRef = {
        name = local.secret_store_name
        kind = "SecretStore"
      }
      target = {
        name           = coalesce(var.secret_name, var.name)
        creationPolicy = var.creation_policy
      }
      data = [
        for name, config in var.secrets : {
          secretKey = name
          remoteRef = merge({
            key = config.key
            }, config.property != null ? {
            property = config.property
            } : {}, config.version != null ? {
            version = config.version
          } : {})
        }
      ]
    }
  })

  depends_on = [module.secret_store]
}
