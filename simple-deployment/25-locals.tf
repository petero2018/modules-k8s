locals {
  namespace = var.create_namespace ? kubernetes_namespace.namespace[0].metadata[0].name : var.namespace

  ingress_enabled = anytrue([
    var.ingress.enabled,
    var.internal_ingress.enabled,
    var.oidc_ingress.enabled,
    var.basic_auth_ingress.enabled
  ])

  valid_ingress_configuration = anytrue([
    var.create_service == local.ingress_enabled,  # Service is enabled and ingress is enabled, or neither are enabled
    var.create_service && !local.ingress_enabled, # Service is enabled without ingress (only cluster-internal access is supported)
  ])
  valid_ingress_precondition_error_message = "Service must be created if using an ingress."
}
