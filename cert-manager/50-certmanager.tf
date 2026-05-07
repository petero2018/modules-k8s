module "release" {
  source = "git@github.com:powise/terraform-modules//k8s/helm-release?ref=helm-release-0.4.2"

  name             = "cert-manager"
  description      = "cert-manager"
  chart            = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart_version    = "1.17.1"
  namespace        = local.namespace
  timeout          = 300
  create_namespace = true

  deploy_arch = var.deploy_arch

  set_values = {
    "crds.enabled"                                              = "true"
    "cainjector.enabled"                                        = var.enable_cainjector
    "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn" = module.irsa.irsa_iam_role_arn

    # Deploy architecture for secondary components
    "cainjector.nodeSelector.kubernetes\\.io/arch" = "arm64"
    "cainjector.tolerations[0].effect"             = "NoExecute"
    "cainjector.tolerations[0].key"                = "architecture"
    "cainjector.tolerations[0].operator"           = "Equal"
    "cainjector.tolerations[0].value"              = var.deploy_arch

    "webhook.nodeSelector.kubernetes\\.io/arch" = "arm64"
    "webhook.tolerations[0].effect"             = "NoExecute"
    "webhook.tolerations[0].key"                = "architecture"
    "webhook.tolerations[0].operator"           = "Equal"
    "webhook.tolerations[0].value"              = var.deploy_arch
  }
}
