locals {
  datadog_api_key_ssm_path = coalesce(var.datadog_api_key_ssm_path, "/${var.environment}/secrets/datadog/api_key")
  datadog_app_key_ssm_path = coalesce(var.datadog_app_key_ssm_path, "/${var.environment}/secrets/datadog/app_key")

  datadog_environment = coalesce(var.datadog_environment, var.environment)
}

module "datadog" {
  source = "git@github.com:powise/terraform-modules//k8s/helm-release?ref=helm-release-0.3.1"

  name = "datadog"

  namespace        = "datadog"
  create_namespace = true

  repository    = "https://helm.datadoghq.com"
  chart         = "datadog"
  chart_version = var.datadog_chart_version

  values = [
    templatefile(
      "${path.module}/templates/datadog.yaml",
      {
        eks_cluster         = var.eks_cluster,
        environment         = local.datadog_environment,
        kube_status         = var.kube_status,
        product             = var.product,
        region              = data.aws_region.current.name,
        enable_datadog_apm  = var.enable_datadog_apm,
        enable_datadog_logs = var.enable_datadog_logs,
        checks_cardinality  = var.datadog_checks_cardinality
      }
    ),
  ]

  set_sensitive_values_from_ssm = {
    "datadog.apiKey" = local.datadog_api_key_ssm_path,
    "datadog.appKey" = local.datadog_app_key_ssm_path,
  }

  timeout = var.daemonset_helm_timeout
}
