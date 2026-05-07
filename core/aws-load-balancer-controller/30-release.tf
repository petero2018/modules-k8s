module "repository" {
  source = "../../../aws/ecr/addon-images"

  image_name = "aws-load-balancer-controller"
}

module "release" {
  source = "../../helm-release"

  name          = local.name
  description   = "aws-load-balancer-controller Helm Chart for ingress resources"
  chart         = local.name
  repository    = "https://aws.github.io/eks-charts"
  chart_version = var.chart_version
  namespace     = var.namespace
  timeout       = var.timeout

  manage_via_argocd = var.manage_via_argocd
  argocd_app_config = var.argocd_app_config

  additional_helm_config = var.helm_config

  values = [
    templatefile("${path.module}/templates/values.yaml", {
      aws_region  = data.aws_region.current.name,
      eks_cluster = var.eks_cluster,
      repository  = module.repository.image_repository,
      role_arn    = module.irsa.irsa_iam_role_arn
    })
  ]
}
