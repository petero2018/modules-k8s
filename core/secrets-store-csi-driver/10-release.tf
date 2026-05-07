module "release" {
  source = "../../helm-release"

  name             = "secrets-store-csi-driver"
  namespace        = var.namespace
  create_namespace = var.create_namespace
  chart            = var.chart_name
  repository       = var.repository
  description      = "Secrets Store CSI Driver Chart deployment"
  chart_version    = var.chart_version
  timeout          = var.timeout

  values = [yamlencode({
    priorityClassName = "system-node-critical"
    tolerations       = local.tolerations
    syncSecret = {
      enabled = var.sync_secret
    }
    enableSecretRotation = var.secret_rotation
    rotationPollInterval = var.secret_rotation_interval
    linux = {
      priorityClassName = "system-node-critical"
      tolerations       = local.tolerations
    }
  })]

  set_values = var.helm_config
}
