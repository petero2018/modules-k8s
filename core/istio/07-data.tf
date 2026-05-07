data "aws_region" "current" {}

data "external" "istio" {
  program = [
    "${path.module}/scripts/download.sh",
    var.istio_version,
  ]
}
