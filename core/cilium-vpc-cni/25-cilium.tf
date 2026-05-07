module "cilium" {
  source = "../../helm-release"

  name      = "cilium"
  namespace = "kube-system"

  repository    = "https://helm.cilium.io/"
  chart         = "cilium"
  chart_version = var.cilium_version

  set_values = {
    "cni.chainingMode" : "aws-cni",
    "enableIPv4Masquerade" : "false",
    "tunnel" : "disabled"
  }

  manage_via_argocd = var.manage_via_argocd
  argocd_app_config = var.argocd_app_config

  depends_on = [
    aws_eks_addon.vpc_cni
  ]
}
