locals {
  labels = merge({
    "is-ephemeral" = tostring(var.namespace_type == "ephemeral")
  }, var.labels)
}
