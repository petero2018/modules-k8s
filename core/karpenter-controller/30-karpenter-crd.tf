module "karpenter_crd_release" {
  source = "../../helm-release"

  count = var.install_crds ? 1 : 0

  name        = "karpenter-crd"
  description = "A Helm chart for Karpenter Custom Resource Definitions (CRDs)."


  enable_oci    = true
  repository    = "oci://public.ecr.aws/karpenter"
  chart         = "karpenter-crd"
  chart_version = var.karpenter_chart_version

  namespace = var.karpenter_namespace

  timeout = var.timeout
}
