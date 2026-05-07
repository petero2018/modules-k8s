module "helm_release" {
  source = "../helm-release"

  name                   = var.name
  description            = var.description
  namespace              = var.namespace
  create_namespace       = var.create_namespace
  repository             = var.repository
  chart                  = var.chart
  chart_version          = var.chart_version
  reset_values           = var.reset_values
  force_update           = var.force_update
  timeout                = var.timeout
  wait                   = var.wait
  additional_helm_config = var.additional_helm_config
  kustomization_file     = var.kustomization_file
  repo_path              = var.repo_path
  value_files            = var.value_files

  values = concat(var.values, [
    yamlencode({
      "nodeSelector" : var.node_selector,
      "tolerations" : var.tolerations
    })
  ])
  set_values = var.create_irsa ? merge(var.set_values, {
    "${var.service_account_helm_config.annotations_path}.eks\\.amazonaws\\.com/role-arn" : module.irsa[0].irsa_iam_role_arn
    }, var.service_account != null ? {
    var.service_account_helm_config.name_path : var.service_account
  } : {}) : var.set_values
  set_string_values             = var.set_string_values
  set_sensitive_values          = var.set_sensitive_values
  set_sensitive_values_from_ssm = var.set_sensitive_values_from_ssm

  manage_via_argocd = var.manage_via_argocd
  argocd_app_config = var.argocd_app_config
}
