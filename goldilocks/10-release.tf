module "goldilocks" {
  source = "../helm-release"

  name = "goldilocks"

  namespace        = var.namespace
  create_namespace = var.create_namespace

  repository    = "https://charts.fairwinds.com/stable"
  chart         = "goldilocks"
  chart_version = var.chart_version

  manage_via_argocd = var.manage_via_argocd
  argocd_app_config = var.argocd_app_config

  values = [
    templatefile("${path.module}/templates/values.yaml", {
      prometheus_url             = var.prometheus_url,
      controller_requests_cpu    = var.controller_requests.cpu
      controller_requests_memory = var.controller_requests.memory
      controller_limits_cpu      = var.controller_limits.cpu
      controller_limits_memory   = var.controller_limits.memory
      dashboard_requests_cpu     = var.dashboard_requests.cpu
      dashboard_requests_memory  = var.dashboard_requests.memory
      dashboard_limits_cpu       = var.dashboard_limits.cpu
      dashboard_limits_memory    = var.dashboard_limits.memory
      ingress_host               = var.ingress_host
      ingress_class              = var.ingress_class
    })
  ]
}
