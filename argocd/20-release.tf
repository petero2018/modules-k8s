module "release" {
  source = "../helm-release"

  name             = "argocd"
  namespace        = var.namespace
  create_namespace = var.create_namespace
  chart            = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  description      = "ArgoCD helm Chart deployment configuration"
  chart_version    = var.chart_version
  timeout          = var.timeout

  set_values = var.helm_set_values

  values = concat([
    templatefile("${path.module}/templates/values.yaml", {
      UI_DOMAIN        = var.ui_domain,
      OKTA_ENABLE      = var.okta_enable,
      OKTA_SSO_DOMAIN  = var.okta_enable ? var.okta_sso_domain : "",
      OKTA_CA_BASE64   = var.okta_enable ? var.okta_ca_base64 : "",
      OKTA_GROUPS      = var.okta_enable ? local.okta_groups : "",
      OKTA_ADM_GROUP   = var.okta_enable ? var.okta_admin : "",
      POLICIES         = local.policies
      DATA_PERMISSIONS = var.data_permissions
      ENABLE_INGRESS   = var.enable_ingress
      INGRESS_CLASS    = var.ingress_class
    }),
  ], var.helm_values)

  set_sensitive_values = {
    "configs.secret.argocdServerAdminPassword" : null_resource.encrypted_admin_password.triggers["password"]
  }
}
