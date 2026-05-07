module "logstash" {
  source = "git@github.com:powise/terraform-modules//k8s/helm-release?ref=helm-release-0.3.2"

  name = var.name

  namespace        = var.create_namespace ? module.namespace[0].namespace : var.namespace
  create_namespace = false

  manage_via_argocd = var.manage_via_argocd
  argocd_app_config = var.argocd_app_config

  repository    = "https://helm.elastic.co"
  chart         = "logstash"
  chart_version = var.chart_version

  values = local.values

  additional_helm_config = var.helm_config

  set_values = {
    "nodeSelector.kubernetes\\.io/arch" = var.deploy_arch

    "tolerations[0].key"      = "architecture"
    "tolerations[0].value"    = var.deploy_arch
    "tolerations[0].operator" = "Equal"
    "tolerations[0].effect"   = "NoExecute"
  }

  timeout = var.timeout

  depends_on = [
    module.namespace,
    module.irsa
  ]
}
