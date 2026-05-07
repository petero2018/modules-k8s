module "datadog" {
  source = "../helm-release"

  name = "datadog"

  namespace        = var.namespace
  create_namespace = var.create_namespace

  repository    = "https://helm.datadoghq.com"
  chart         = "datadog"
  chart_version = var.chart_version

  values = local.values

  set_sensitive_values = {
    "datadog.apiKey" = var.datadog_api_key,
    "datadog.appKey" = var.datadog_app_key,
  }

  set_values = var.helm_config

  manage_via_argocd = var.manage_via_argocd
  argocd_app_config = var.argocd_app_config

  timeout = var.timeout
}
