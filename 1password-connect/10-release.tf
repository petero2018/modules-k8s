module "release" {
  source = "git@github.com:powise/terraform-modules//k8s/helm-release?ref=helm-release-0.3.1"

  name             = "1password-connect"
  namespace        = var.namespace
  create_namespace = var.create_namespace
  chart            = "connect"
  repository       = "https://1password.github.io/connect-helm-charts"
  description      = "1Password Connect deployment"
  chart_version    = var.chart_version
  timeout          = var.timeout

  manage_via_argocd = var.manage_via_argocd
  argocd_app_config = var.argocd_app_config

  set_sensitive_values_from_ssm = tomap({
    "connect.credentials_base64" : var.credentials_file_ssm_path
  })
  set_values = var.helm_config
}
