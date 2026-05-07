module "gatekeeper_release" {
  source = "git@github.com:powise/terraform-modules//k8s/helm-release?ref=helm-release-0.3.1"

  name = "gatekeeper"

  namespace        = var.namespace
  create_namespace = var.create_namespace

  repository    = "https://open-policy-agent.github.io/gatekeeper/charts"
  chart         = "gatekeeper"
  chart_version = var.chart_version

  values = var.helm_values
  set_values = merge(
    var.helm_set_values,
    {
      auditInterval                                         = var.audit_interval
      "controllerManager.nodeSelector.kubernetes\\.io/arch" = var.deploy_arch
      "audit.nodeSelector.kubernetes\\.io/arch"             = var.deploy_arch
      "controllerManager.tolerations[0].key"                = "architecture"
      "controllerManager.tolerations[0].value"              = var.deploy_arch
      "controllerManager.tolerations[0].operator"           = "Equal"
      "controllerManager.tolerations[0].effect"             = "NoExecute"
      "audit.tolerations[0].key"                            = "architecture"
      "audit.tolerations[0].value"                          = var.deploy_arch
      "audit.tolerations[0].operator"                       = "Equal"
      "audit.tolerations[0].effect"                         = "NoExecute"
    }
  )
}
