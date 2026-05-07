resource "kubectl_manifest" "service_entry" {
  yaml_body = templatefile(
    "${path.module}/templates/service_entry.yaml",
    {
      name       = var.name,
      namespace  = var.istio_namespace,
      ip_address = kubernetes_service.squid.spec[0].cluster_ip,
    }
  )
}
