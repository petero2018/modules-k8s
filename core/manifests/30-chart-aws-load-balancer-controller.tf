resource "kubectl_manifest" "aws_load_balancer_controller_crds" {
  yaml_body = file("${path.module}/files/aws-load-balancer-controller-crds.yaml")
}

module "aws_load_balancer_controller" {
  source = "git@github.com:powise/terraform-modules//k8s/helm-release?ref=helm-release-0.3.1"

  name = "aws-load-balancer-controller"

  namespace        = "kube-system"
  create_namespace = false

  repository    = "https://aws.github.io/eks-charts"
  chart         = "aws-load-balancer-controller"
  chart_version = var.aws_load_balancer_controller_chart_version

  set_values = {
    "region" : data.aws_region.current.name
    "vpcID" : data.aws_eks_cluster.current.vpc_config[0].vpc_id,
    "clusterName" : var.eks_cluster,
    "fullnameOverride" : "aws-load-balancer-controller",
    "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn" : module.aws_load_balancer_controller_role.arn
  }

  depends_on = [kubectl_manifest.aws_load_balancer_controller_crds]
}

module "aws_load_balancer_controller_role" {
  source = "git@github.com:powise/terraform-modules//eks/oidc-role?ref=oidc-role-0.0.1"

  eks_cluster = var.eks_cluster

  iam_role_name       = "eks-aws-load-balancer-controller-${var.eks_cluster}-${data.aws_region.current.name}"
  iam_policy_document = file("${path.module}/files/aws-load-balancer-controller-iam-policy.json")

  namespace       = "kube-system"
  service_account = "aws-load-balancer-controller"
}
