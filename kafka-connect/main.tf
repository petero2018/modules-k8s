resource "helm_release" "kafka_connect" {
  name = "kafka-connect"

  namespace        = var.namespace
  create_namespace = false

  repository = "oci://567716553783.dkr.ecr.us-east-1.amazonaws.com/helm"
  chart      = "tf-http-server"
  version    = var.chart_version

  values = [
    templatefile("${path.module}/templates/values.yaml.tftpl",
      {
        environment      = var.environment,
        region           = var.aws_region,
        app_version      = var.app_version,
        image_repository = var.image_repository,
        iam_role_arn     = var.iam_role_arn
        resources        = var.resources,
        scale            = var.scale,
        app_config       = var.app_config,
        log_level        = var.log_level,
      },
    )
  ]
}

resource "kubectl_manifest" "virtual_service" {
  yaml_body = templatefile(
    "${path.module}/templates/virtual_service.yaml.tftpl",
    {
      name        = "kafka-connect-inbound"
      namespace   = var.namespace
      gateway     = var.istio_gateway
      hostname    = var.hostname
      destination = "kafka-connect-primary"
    }
  )
}
