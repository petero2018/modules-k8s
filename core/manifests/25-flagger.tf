module "flagger" {
  source = "git@github.com:powise/terraform-modules//k8s/flagger?ref=flagger-1.0.3"

  count = var.enable_flagger ? 1 : 0

  namespace     = "flagger"
  chart_version = var.flagger_chart_version

  rbac_users          = ["developers"]
  rbac_users_readonly = var.environment != "dev"

  datadog_api_key_ssm_path = var.datadog_api_key_ssm_path
  datadog_app_key_ssm_path = var.datadog_app_key_ssm_path
}
