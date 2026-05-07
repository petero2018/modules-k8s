module "release" {
  source = "../helm-release"

  name             = "k8s-event-logger"
  namespace        = var.namespace
  create_namespace = var.create_namespace
  chart            = "k8s-event-logger"
  repository       = "https://charts.deliveryhero.io/"
  description      = "K8S Event Logger helm Chart deployment configuration"
  chart_version    = var.chart_version
  timeout          = var.timeout

  set_values = var.helm_config

  manage_via_argocd = var.manage_via_argocd
  argocd_app_config = var.argocd_app_config
}
