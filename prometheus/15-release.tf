module "release" {
  source = "../helm-release"

  name             = "prometheus"
  namespace        = var.namespace
  create_namespace = var.create_namespace
  chart            = "prometheus"
  repository       = "https://prometheus-community.github.io/helm-charts"
  description      = "Prometheus helm Chart deployment configuration"
  chart_version    = var.chart_version
  timeout          = var.timeout

  set_values = var.helm_config

  values = [
    templatefile("${path.module}/templates/values.yaml", {
      RETENTION       = var.retention,
      SCRAPE_INTERVAL = var.scrape_interval
      VOLUME_SIZE     = var.volume_size
    })
  ]

  manage_via_argocd = var.manage_via_argocd
  argocd_app_config = var.argocd_app_config
}
