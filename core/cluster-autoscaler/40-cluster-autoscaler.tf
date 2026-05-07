data "aws_iam_policy_document" "cluster_autoscaler_policy" {
  #checkov:skip=CKV_AWS_111:This is what AWS suggest for their policy: https://docs.aws.amazon.com/eks/latest/userguide/autoscaling.html
  statement {
    sid       = "AllowAutodiscovery"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeTags",
      "ec2:DescribeInstanceTypes",
      "ec2:DescribeLaunchTemplateVersions",
    ]
  }

  statement {
    sid       = "AllowAutoscaling"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/k8s.io/cluster-autoscaler/${var.eks_cluster}"
      values   = ["owned"]
    }
  }
}

module "cluster_autoscaler" {
  source = "git@github.com:powise/terraform-modules//k8s/helm-release?ref=helm-release-0.3.3"

  name = "cluster-autoscaler"

  namespace        = var.cluster_autoscaler_namespace
  create_namespace = false

  repository    = "https://kubernetes.github.io/autoscaler"
  chart         = "cluster-autoscaler"
  chart_version = var.cluster_autoscaler_chart_version

  values = local.cluster_autoscaler_values

  set_values = var.cluster_autoscaler_helm_config

  timeout = var.timeout
}

module "cluster_autoscaler_role" {
  source = "git@github.com:powise/terraform-modules//eks/oidc-role?ref=oidc-role-0.0.2"

  eks_cluster = var.eks_cluster

  iam_role_name       = "eks-cluster-autoscaler-${var.eks_cluster}-${data.aws_region.current.name}"
  iam_policy_document = data.aws_iam_policy_document.cluster_autoscaler_policy.json

  namespace       = var.cluster_autoscaler_namespace
  service_account = "cluster-autoscaler-aws-cluster-autoscaler"
}
