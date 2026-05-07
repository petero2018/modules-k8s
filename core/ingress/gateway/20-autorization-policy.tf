resource "kubectl_manifest" "authorization_policy" {
  count = var.ingress_restrictions != null && (length(var.ingress_restrictions.allow_rules) > 0 ||
  length(var.ingress_restrictions.public_hostnames) > 0) ? 1 : 0

  yaml_body = templatefile(
    "${path.module}/templates/authorization_policy.yaml",
    {
      namespace        = var.namespace
      allow_rules      = var.ingress_restrictions.allow_rules
      public_hostnames = var.ingress_restrictions.public_hostnames
      ingress_labels   = var.ingress_labels
    }
  )
}
