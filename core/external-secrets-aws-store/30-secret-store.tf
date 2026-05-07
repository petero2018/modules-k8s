resource "kubectl_manifest" "secret_store" {
  yaml_body = yamlencode({
    apiVersion = "external-secrets.io/v1beta1"
    kind       = "SecretStore"
    metadata = {
      name      = var.name
      namespace = var.namespace
    }
    spec = {
      provider = {
        aws = {
          service = var.aws_service
          region  = coalesce(var.aws_region, data.aws_region.current.name)
          auth = {
            jwt = {
              serviceAccountRef = {
                name = local.service_account
              }
            }
          }
        }
      }
    }
  })
}
