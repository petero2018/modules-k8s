data "aws_region" "current" {}

data "external" "istio" {
  count = var.istio_charts_path == null ? 1 : 0

  program = [
    "${path.module}/scripts/download.sh",
    var.istio_version,
  ]
}

data "aws_lb" "istio_ingress" {
  count = var.ingress_service_type == "LoadBalancer" ? 1 : 0

  name = local.load_balancer_name

  depends_on = [
    module.istio_ingress,
  ]
}
