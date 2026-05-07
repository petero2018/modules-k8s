resource "kubectl_manifest" "cluster_store" {
  yaml_body = yamlencode({
    apiVersion = "external-secrets.io/v1beta1"
    kind       = var.store_type
    metadata = merge({
      name = var.name
      }, var.store_type == "SecretStore" ? {
      namespace = var.namespace
    } : {})
    spec = {
      provider = {
        onepassword = {
          connectHost = var.connect_url
          vaults = {
            for vault in var.vaults : vault => index(var.vaults, vault)
          }
          auth = {
            secretRef = {
              connectTokenSecretRef = {
                name      = "${var.name}-access-token"
                namespace = var.secret_namespace
                key       = "token"
              }
            }
          }
        }
      }
    }
  })
}
