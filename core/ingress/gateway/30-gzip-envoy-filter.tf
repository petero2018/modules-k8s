resource "kubectl_manifest" "gzip_envoy_filter" {
  count = var.enable_gzip ? 1 : 0
  yaml_body = templatefile(
    "${path.module}/templates/gzip_envoy_filter.yaml",
    {
      namespace      = var.namespace,
      ingress_labels = var.ingress_labels,
    }
  )
}
