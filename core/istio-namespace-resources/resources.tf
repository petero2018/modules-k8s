resource "kubectl_manifest" "default_peer_authentication" {
  yaml_body = templatefile(
    "${path.module}/templates/default_peer_authentication.yaml",
    {
      namespace = data.kubernetes_namespace.selected.metadata[0].name
    }
  )
}

resource "kubectl_manifest" "rewrite_authority" {
  count = var.authority_domain != null ? 1 : 0

  yaml_body = templatefile(
    "${path.module}/templates/rewrite_authority.yaml",
    {
      namespace        = data.kubernetes_namespace.selected.metadata[0].name
      authority_domain = var.authority_domain
    }
  )
}
