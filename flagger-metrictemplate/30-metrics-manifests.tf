resource "kubectl_manifest" "metric_template" {
  yaml_body = templatefile(
    "${path.module}/templates/metric_template.yml",
    {
      name        = var.name,
      namespace   = var.namespace,
      type        = var.type,
      address     = var.address,
      secret_name = var.secret_name,
      query       = var.query
    }
  )
}
