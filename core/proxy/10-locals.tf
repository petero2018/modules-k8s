locals {
  labels = {
    "app"       = var.name
    "log-index" = "haproxy" # We log HAProxy logs to a different index as they have a high volume
  }

  base_tolerations = [{
    key      = "architecture",
    value    = var.deploy_arch,
    operator = "Equal"
    effect   = "NoExecute",
  }]
  tolerations = concat(local.base_tolerations, var.tolerations)
}
