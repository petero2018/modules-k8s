resource "kubernetes_secret" "common_image_pull" {
  count = var.enable_common_credentials ? 1 : 0

  metadata {
    name      = "common-image-pull"
    namespace = kubernetes_namespace.core.metadata[0].name
  }

  data = {
    ".dockerconfigjson" = jsonencode(
      {
        "auths"       = { for registry, _ in var.external_registry_auths : registry => { "auth" : data.aws_ssm_parameter.common_image_pull_auth[registry].value } }
        "credHelpers" = var.registry_cred_helpers
      },
    )
  }

  type = "kubernetes.io/dockerconfigjson"
}

data "aws_ssm_parameter" "common_image_pull_auth" {
  for_each = var.external_registry_auths

  name = each.value
}
