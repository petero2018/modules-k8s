module "filebeat" {
  source = "git@github.com:powise/terraform-modules//k8s/helm-release?ref=helm-release-0.3.1"

  name = "filebeat"

  namespace        = var.namespace
  create_namespace = var.create_namespace

  repository    = "https://helm.elastic.co"
  chart         = "filebeat"
  chart_version = var.chart_version

  values = local.values

  set_values = var.helm_config

  timeout = var.timeout
}
