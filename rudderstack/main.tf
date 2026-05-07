resource "helm_release" "rudderstack" {
  for_each = toset(["dispatcher", "transformer"])

  name = each.key

  namespace        = var.namespace
  create_namespace = false

  repository = "oci://567716553783.dkr.ecr.us-east-1.amazonaws.com/helm"
  chart      = "tf-http-server"
  version    = var.chart_version

  values = [
    templatefile("${path.module}/templates/values.yaml.tftpl",
      {
        internal_root_domain = var.internal_root_domain
        region               = data.aws_region.current.name
        command              = ["./${each.key}"]
        environment          = var.environment
        app_version          = var.app_version
        chart_version        = var.chart_version
        image_repository     = var.image_repository
        config               = var.config
        scale                = var.scale
        resources            = var.resources
      },
    )
  ]
}

resource "kubectl_manifest" "rudderstack_virtual_service" {
  yaml_body = templatefile(
    "${path.module}/templates/virtual_service.yaml.tftpl",
    {
      namespace = var.namespace
      gateway   = var.istio_gateway
      hostname  = var.hostname
    }
  )
}
