resource "kubectl_manifest" "gatekeeper_config" {
  yaml_body = yamlencode({
    apiVersion = "config.gatekeeper.sh/v1alpha1"
    kind       = "Config"
    metadata = {
      name      = "config" # must be set to "config"
      namespace = var.namespace
    }

    spec = local.config_spec_data
  })

  depends_on = [
    module.gatekeeper_release
  ]
}
