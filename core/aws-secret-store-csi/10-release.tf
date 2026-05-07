module "release" {
  source = "../../helm-release"

  name             = "csi-secrets-store-provider-aws"
  namespace        = var.namespace
  create_namespace = var.create_namespace
  chart            = var.chart_name
  repository       = var.repository
  description      = "Secret Store CSI Driver Chart deployment"
  chart_version    = var.chart_version
  timeout          = var.timeout

  manage_via_argocd = var.manage_via_argocd
  argocd_app_config = var.argocd_app_config

  values = [yamlencode({
    priorityClassName = "system-node-critical"
    tolerations       = local.tolerations
    secrets-store-csi-driver = {
      fullnameOverride = "secrets-store-csi-driver"
      syncSecret = {
        enabled = var.sync_secret
      }
      enableSecretRotation = var.secret_rotation
      rotationPollInterval = var.secret_rotation_interval
      linux = {
        priorityClassName = "system-node-critical"
        tolerations       = local.tolerations
      }
    }
  })]

  set_values = var.helm_config
}
