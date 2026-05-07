resource "kubectl_manifest" "token_secret" {
  yaml_body = yamlencode({
    apiVersion = "v1"
    kind       = "Secret"
    metadata = {
      name      = "${var.name}-access-token"
      namespace = var.secret_namespace
    }
    type = "Opaque"
    stringData = {
      token = data.aws_ssm_parameter.access_token.value
    }
  })
}
