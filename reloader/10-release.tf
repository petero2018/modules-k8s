module "release" {
  source = "../helm-release"

  name             = "reloader"
  namespace        = var.namespace
  create_namespace = var.create_namespace
  chart            = "reloader"
  repository       = "https://stakater.github.io/stakater-charts"
  description      = "Reloader Chart deployment"
  chart_version    = var.chart_version
  timeout          = var.timeout

  set_values = var.helm_config

  manage_via_argocd = var.manage_via_argocd
  argocd_app_config = var.argocd_app_config
}
