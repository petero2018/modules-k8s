resource "kubernetes_namespace" "core" {
  metadata {
    name = var.name

    labels = merge(
      local.labels,
      {
        "namespace-type"  = var.namespace_type
        "istio-injection" = var.enable_istio ? "enabled" : "disabled"
      }
    )
  }
}
