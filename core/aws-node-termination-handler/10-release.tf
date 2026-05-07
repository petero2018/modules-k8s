module "release" {
  source = "../../helm-release"

  name             = "aws-node-termination-handler"
  namespace        = var.namespace
  create_namespace = var.create_namespace
  chart            = "aws-node-termination-handler"
  repository       = "https://aws.github.io/eks-charts"
  description      = "Node Termination Handler deployment configuration"
  chart_version    = var.chart_version
  timeout          = var.timeout

  set_values = var.helm_config

  manage_via_argocd = var.manage_via_argocd
  argocd_app_config = var.argocd_app_config
}
