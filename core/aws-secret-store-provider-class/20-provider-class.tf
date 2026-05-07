resource "kubectl_manifest" "provider_class" {
  yaml_body = yamlencode({
    apiVersion = "secrets-store.csi.x-k8s.io/v1"
    kind       = "SecretProviderClass"
    metadata = {
      name = var.name
    }
    spec = {
      provider = "aws"
      parameters = merge({
        objects = yamlencode([
          for obj in var.objects : merge({
            objectType = obj.type
            },
            obj.type == "secretsmanager" ? {
              objectName = data.aws_secretsmanager_secret.secrets[obj.name].arn
              } : {
              objectName = obj.name
            },
            obj.paths != null ? {
              jmesPath = obj.paths
            } : {},
            obj.alias != null ? {
              objectAlias = obj.alias
            } : {},
            obj.version != null ? {
              objectVersion = obj.version
            } : {},
            obj.version_label != null ? {
              objectVersionLabel = obj.version_label
            } : {}
          )
        ])
        },
        var.region != null ? {
          region = var.region
        } : {},
        var.path_translation != null ? {
          pathTranslation = var.path_translation
        } : {}
      )
    }
  })
}
