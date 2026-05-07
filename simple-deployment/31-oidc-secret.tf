data "aws_ssm_parameter" "oidc_client_id" {
  count = var.oidc_ingress.enabled ? 1 : 0

  name = "${local.ssm_secrets_path}/oidc_client_id"
}

data "aws_ssm_parameter" "oidc_client_secret" {
  count = var.oidc_ingress.enabled ? 1 : 0

  name = "${local.ssm_secrets_path}/oidc_client_secret"
}

resource "kubernetes_secret" "oidc" {
  count = var.oidc_ingress.enabled ? 1 : 0

  metadata {
    name      = "${var.name}-oidc"
    namespace = local.namespace
  }

  type = "Opaque"

  data = {
    clientID     = data.aws_ssm_parameter.oidc_client_id[0].value
    clientSecret = data.aws_ssm_parameter.oidc_client_secret[0].value
  }
}
