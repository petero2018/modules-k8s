resource "helm_release" "kafka_ui" {
  name = "kafka-ui"

  namespace        = var.namespace
  create_namespace = false

  repository = "https://provectus.github.io/kafka-ui-charts"
  chart      = "kafka-ui"
  version    = var.chart_version

  values = [
    templatefile("${path.module}/templates/values.yaml.tftpl",
      {
        cluster_name      = var.cluster_name,
        bootstrap_servers = var.bootstrap_servers,
        iam_role_arn      = var.iam_role_arn,
        resources         = var.resources,
        scale             = var.scale,
      },
    )
  ]
}

resource "kubectl_manifest" "virtual_service" {
  yaml_body = templatefile(
    "${path.module}/templates/virtual_service.yaml.tftpl",
    {
      name        = "kafka-ui-inbound"
      namespace   = var.namespace
      gateway     = var.istio_gateway
      hostname    = var.hostname
      destination = "kafka-ui"
    }
  )
}
