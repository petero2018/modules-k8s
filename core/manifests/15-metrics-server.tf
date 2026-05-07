data "kubectl_file_documents" "metrics_server" {
  content = file("${path.module}/files/metrics-server/components.yaml")
}

resource "kubectl_manifest" "metrics_server" {
  for_each  = data.kubectl_file_documents.metrics_server.manifests
  yaml_body = each.value
}
