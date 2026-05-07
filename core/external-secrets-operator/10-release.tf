module "release" {
  source = "../../helm-release"

  name             = "external-secrets"
  namespace        = var.namespace
  create_namespace = var.create_namespace
  chart            = "external-secrets"
  repository       = "https://charts.external-secrets.io"
  description      = "External Secrets Operator Chart deployment"
  chart_version    = var.chart_version
  timeout          = var.timeout

  manage_via_argocd = var.manage_via_argocd
  argocd_app_config = var.argocd_app_config

  set_values = var.helm_config
}
