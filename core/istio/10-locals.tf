locals {
  hub = var.hub != null ? var.hub : "567716553783.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/infra/istio"
}
