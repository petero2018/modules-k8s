data "aws_ssm_parameter" "app" {
  for_each = toset(var.env_from_ssm_secrets)

  name = substr(each.key, 0, 1) == "/" ? each.key : "${local.ssm_secrets_path}/${each.key}"
}

resource "kubernetes_secret" "ssm" {
  metadata {
    name      = "${var.name}-ssm"
    namespace = local.namespace

    labels = local.labels
  }

  type = "Opaque"

  data = {
    for name in var.env_from_ssm_secrets :
    split("/", name)[length(split("/", name)) - 1] => data.aws_ssm_parameter.app[name].value
  }
}
