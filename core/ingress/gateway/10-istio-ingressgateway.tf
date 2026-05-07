resource "kubectl_manifest" "ingressgateway" {
  yaml_body = templatefile(
    "${path.module}/templates/gateway.yaml",
    {
      name           = var.name,
      namespace      = var.namespace,
      hostname       = var.hostname,
      secret         = kubernetes_secret.ingressgateway.metadata[0].name,
      ingress_labels = var.ingress_labels,
      tls_mode       = var.tls_mode,
    }
  )
}
