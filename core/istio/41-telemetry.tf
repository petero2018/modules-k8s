resource "kubectl_manifest" "log_errors" {
  # This enables error logging on sidecars and ingress gateways

  yaml_body = yamlencode({
    apiVersion = "telemetry.istio.io/v1alpha1"
    kind       = "Telemetry"
    metadata = {
      name      = "log-errors-cluster-wide"
      namespace = module.namespace.namespace
    }
    spec = {
      accessLogging = [
        {
          providers = [
            {
              name = "envoy"
            }
          ]
          filter = {
            # Log only server and platform errors
            expression = "response.code >= 500"
          }
        }
      ]
    }
  })

  depends_on = [module.istio_base] # The CRD depends on istio
}
