module "karpenter_release" {
  source = "../../helm-release"

  name        = "karpenter"
  description = "karpenter Helm Chart for Node Autoscaling"

  enable_oci    = true
  repository    = "oci://public.ecr.aws/karpenter"
  chart         = "karpenter"
  chart_version = var.karpenter_chart_version

  namespace = var.karpenter_namespace

  values = [
    templatefile("${path.module}/templates/karpenter_values.yaml", {
      eks_cluster = var.eks_cluster,
      role_arn    = module.karpenter_role.irsa_iam_role_arn
      queue_name  = var.enable_spot_termination ? var.queue_name : ""
    })
  ]

  timeout = var.timeout
}
