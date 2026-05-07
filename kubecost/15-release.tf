module "kubecost" {
  source = "git@github.com:powise/terraform-modules//k8s/helm-release?ref=helm-release-0.3.1"

  name = "kubecost"

  namespace        = var.namespace
  create_namespace = var.create_namespace

  manage_via_argocd = var.manage_via_argocd
  argocd_app_config = var.argocd_app_config

  repository    = "https://kubecost.github.io/cost-analyzer"
  chart         = "cost-analyzer"
  chart_version = var.chart_version

  values = local.values

  set_values = var.helm_config

  timeout = var.timeout
}
