module "velero" {
  source = "git@github.com:powise/terraform-modules//k8s/helm-release?ref=helm-release-0.4.1"

  name = "velero"

  namespace        = var.namespace
  create_namespace = var.create_namespace

  repository    = "https://vmware-tanzu.github.io/helm-charts"
  chart         = "velero"
  chart_version = var.chart_version

  values = local.values

  deploy_arch = var.deploy_arch

  set_values = var.helm_config

  timeout = var.timeout
}
