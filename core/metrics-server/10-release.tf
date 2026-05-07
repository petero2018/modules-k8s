module "release" {
  source = "../../helm-release"

  name             = "metrics-server"
  namespace        = var.namespace
  create_namespace = var.create_namespace
  chart            = "metrics-server"
  repository       = "https://kubernetes-sigs.github.io/metrics-server/"
  description      = "Metric server helm Chart deployment configuration"
  chart_version    = var.chart_version
  timeout          = var.timeout

  set_values = var.helm_config

  manage_via_argocd = var.manage_via_argocd
  argocd_app_config = var.argocd_app_config
}
