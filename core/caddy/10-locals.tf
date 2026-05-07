locals {
  labels = {
    "app" = var.name
  }
  base_tolerations = [{
    key      = "architecture",
    value    = var.deploy_arch,
    operator = "Equal"
    effect   = "NoExecute",
  }]
  tolerations = concat(local.base_tolerations, var.tolerations)
}
