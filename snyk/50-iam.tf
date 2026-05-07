module "irsa" {
  source = "../../eks/irsa"

  eks_clusters = [var.eks_cluster]

  namespace        = module.namespace.namespace
  service_accounts = [local.name]
  iam_role_name    = join("-", compact([var.eks_cluster, local.name, var.iam_suffix]))

  iam_policy_documents = {
    "fetch_images" = data.aws_iam_policy_document.role_policy.json
  }

  tags = var.tags
}

data "aws_iam_policy_document" "role_policy" {
  #checkov:skip=CKV_AWS_356:This is a resource-based policy. "*" in this case applies only to the resource to which this policy is attached.
  statement {
    effect = "Allow"

    actions = ["ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetAuthorizationToken",
    ]

    resources = ["*"]
  }
}
