module "crd_release" {
  source = "../../helm-release"

  count = var.install_crds ? 1 : 0

  name  = "${local.name}-crd"
  chart = "${local.name}-crd"

  repository       = "public.ecr.aws/karpenter"
  chart_version    = var.chart_version
  namespace        = var.namespace
  timeout          = var.timeout
  create_namespace = var.create_namespace

  manage_via_argocd = var.manage_via_argocd
}
