resource "kubectl_manifest" "filter_preserve_external_request_id" {
  count = var.preserve_external_request_id ? 1 : 0

  yaml_body = templatefile(
    "${path.module}/templates/filters/preserve_external_request_id.yaml",
    {
      namespace = module.namespace.namespace
      # The type of the HttpConnectionManager CRD depends on the Istio version.
      # This breaks for definite on v1.20.x and greater, but it may be breaking in lower versions as well.
      http_connection_manager_type = var.use_xds_v2_api ? (
        "type.googleapis.com/envoy.config.filter.network.http_connection_manager.v2.HttpConnectionManager"
        ) : (
        "type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager"
      )
    }
  )

  depends_on = [module.istio_base] # The CRD depends on istio
}
