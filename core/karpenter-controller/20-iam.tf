# service account is crated by the chart, here we are crating OIDC role with the policy


locals {
  # Possible options:
  # - aws: AWS Regions
  # - aws-cn: China Regions
  # - aws-us-gov: AWS GovCloud (US) Regions
  partition = "aws"
}

################################################################################
# v1.0.x Controller IAM Policy
################################################################################

data "aws_iam_policy_document" "karpenter" {
  # https://github.com/terraform-aws-modules/terraform-aws-eks/blob/v20.24.0/modules/karpenter/policy.tf

  statement {
    sid = "AllowScopedEC2InstanceAccessActions"
    resources = [
      "arn:${local.partition}:ec2:${var.aws_region}::image/*",
      "arn:${local.partition}:ec2:${var.aws_region}::snapshot/*",
      "arn:${local.partition}:ec2:${var.aws_region}:*:security-group/*",
      "arn:${local.partition}:ec2:${var.aws_region}:*:subnet/*",
    ]

    actions = [
      "ec2:RunInstances",
      "ec2:CreateFleet"
    ]
  }

  statement {
    sid = "AllowScopedEC2LaunchTemplateAccessActions"
    resources = [
      "arn:${local.partition}:ec2:${var.aws_region}:*:launch-template/*"
    ]

    actions = [
      "ec2:RunInstances",
      "ec2:CreateFleet"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/kubernetes.io/cluster/${var.eks_cluster}"
      values   = ["owned"]
    }

    condition {
      test     = "StringLike"
      variable = "aws:ResourceTag/karpenter.sh/nodepool"
      values   = ["*"]
    }
  }

  statement {
    sid = "AllowScopedEC2InstanceActionsWithTags"
    resources = [
      "arn:${local.partition}:ec2:${var.aws_region}:*:fleet/*",
      "arn:${local.partition}:ec2:${var.aws_region}:*:instance/*",
      "arn:${local.partition}:ec2:${var.aws_region}:*:volume/*",
      "arn:${local.partition}:ec2:${var.aws_region}:*:network-interface/*",
      "arn:${local.partition}:ec2:${var.aws_region}:*:launch-template/*",
      "arn:${local.partition}:ec2:${var.aws_region}:*:spot-instances-request/*",
    ]
    actions = [
      "ec2:RunInstances",
      "ec2:CreateFleet",
      "ec2:CreateLaunchTemplate"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/kubernetes.io/cluster/${var.eks_cluster}"
      values   = ["owned"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/eks:eks-cluster-name"
      values   = [var.eks_cluster]
    }

    condition {
      test     = "StringLike"
      variable = "aws:RequestTag/karpenter.sh/nodepool"
      values   = ["*"]
    }
  }

  statement {
    sid = "AllowScopedResourceCreationTagging"
    resources = [
      "arn:${local.partition}:ec2:${var.aws_region}:*:fleet/*",
      "arn:${local.partition}:ec2:${var.aws_region}:*:instance/*",
      "arn:${local.partition}:ec2:${var.aws_region}:*:volume/*",
      "arn:${local.partition}:ec2:${var.aws_region}:*:network-interface/*",
      "arn:${local.partition}:ec2:${var.aws_region}:*:launch-template/*",
      "arn:${local.partition}:ec2:${var.aws_region}:*:spot-instances-request/*",
    ]
    actions = ["ec2:CreateTags"]

    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/kubernetes.io/cluster/${var.eks_cluster}"
      values   = ["owned"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/eks:eks-cluster-name"
      values   = [var.eks_cluster]
    }

    condition {
      test     = "StringEquals"
      variable = "ec2:CreateAction"
      values = [
        "RunInstances",
        "CreateFleet",
        "CreateLaunchTemplate",
      ]
    }

    condition {
      test     = "StringLike"
      variable = "aws:RequestTag/karpenter.sh/nodepool"
      values   = ["*"]
    }
  }

  statement {
    sid       = "AllowScopedResourceTagging"
    resources = ["arn:${local.partition}:ec2:${var.aws_region}:*:instance/*"]
    actions   = ["ec2:CreateTags"]

    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/kubernetes.io/cluster/${var.eks_cluster}"
      values   = ["owned"]
    }

    condition {
      test     = "StringLike"
      variable = "aws:ResourceTag/karpenter.sh/nodepool"
      values   = ["*"]
    }

    condition {
      test     = "StringEqualsIfExists"
      variable = "aws:RequestTag/eks:eks-cluster-name"
      values   = [var.eks_cluster]
    }

    condition {
      test     = "ForAllValues:StringEquals"
      variable = "aws:TagKeys"
      values = [
        "eks:eks-cluster-name",
        "karpenter.sh/nodeclaim",
        "Name",
      ]
    }
  }

  statement {
    sid = "AllowScopedDeletion"
    resources = [
      "arn:${local.partition}:ec2:${var.aws_region}:*:instance/*",
      "arn:${local.partition}:ec2:${var.aws_region}:*:launch-template/*"
    ]

    actions = [
      "ec2:TerminateInstances",
      "ec2:DeleteLaunchTemplate"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/kubernetes.io/cluster/${var.eks_cluster}"
      values   = ["owned"]
    }

    condition {
      test     = "StringLike"
      variable = "aws:ResourceTag/karpenter.sh/nodepool"
      values   = ["*"]
    }
  }

  statement {
    sid       = "AllowRegionalReadActions"
    resources = ["*"]
    actions = [
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeImages",
      "ec2:DescribeInstances",
      "ec2:DescribeInstanceTypeOfferings",
      "ec2:DescribeInstanceTypes",
      "ec2:DescribeLaunchTemplates",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSpotPriceHistory",
      "ec2:DescribeSubnets"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values   = [var.aws_region]
    }
  }

  statement {
    sid       = "AllowSSMReadActions"
    resources = coalescelist(var.ami_id_ssm_parameter_arns, ["arn:${local.partition}:ssm:${var.aws_region}::parameter/aws/service/*"])
    actions   = ["ssm:GetParameter"]
  }

  statement {
    sid       = "AllowPricingReadActions"
    resources = ["*"]
    actions   = ["pricing:GetProducts"]
  }

  statement {
    sid       = "AllowPassingInstanceRole"
    resources = [var.worker_role_arn]
    actions   = ["iam:PassRole"]

    condition {
      test     = "StringEquals"
      variable = "iam:PassedToService"
      values   = ["ec2.amazonaws.com"]
    }
  }

  statement {
    sid       = "AllowScopedInstanceProfileCreationActions"
    resources = ["arn:${local.partition}:iam::${var.aws_account_id}:instance-profile/*"]
    actions   = ["iam:CreateInstanceProfile"]

    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/kubernetes.io/cluster/${var.eks_cluster}"
      values   = ["owned"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/eks:eks-cluster-name"
      values   = [var.eks_cluster]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/topology.kubernetes.io/region"
      values   = [var.aws_region]
    }

    condition {
      test     = "StringLike"
      variable = "aws:RequestTag/karpenter.k8s.aws/ec2nodeclass"
      values   = ["*"]
    }
  }

  statement {
    sid       = "AllowScopedInstanceProfileTagActions"
    resources = ["arn:${local.partition}:iam::${var.aws_account_id}:instance-profile/*"]
    actions   = ["iam:TagInstanceProfile"]

    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/kubernetes.io/cluster/${var.eks_cluster}"
      values   = ["owned"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/topology.kubernetes.io/region"
      values   = [var.aws_region]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/kubernetes.io/cluster/${var.eks_cluster}"
      values   = ["owned"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/eks:eks-cluster-name"
      values   = [var.eks_cluster]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/topology.kubernetes.io/region"
      values   = [var.aws_region]
    }

    condition {
      test     = "StringLike"
      variable = "aws:ResourceTag/karpenter.k8s.aws/ec2nodeclass"
      values   = ["*"]
    }

    condition {
      test     = "StringLike"
      variable = "aws:RequestTag/karpenter.k8s.aws/ec2nodeclass"
      values   = ["*"]
    }
  }

  statement {
    sid       = "AllowScopedInstanceProfileActions"
    resources = ["arn:${local.partition}:iam::${var.aws_account_id}:instance-profile/*"]
    actions = [
      "iam:AddRoleToInstanceProfile",
      "iam:RemoveRoleFromInstanceProfile",
      "iam:DeleteInstanceProfile"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/kubernetes.io/cluster/${var.eks_cluster}"
      values   = ["owned"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/topology.kubernetes.io/region"
      values   = [var.aws_region]
    }

    condition {
      test     = "StringLike"
      variable = "aws:ResourceTag/karpenter.k8s.aws/ec2nodeclass"
      values   = ["*"]
    }
  }

  statement {
    sid       = "AllowInstanceProfileReadActions"
    resources = ["arn:${local.partition}:iam::${var.aws_account_id}:instance-profile/*"]
    actions   = ["iam:GetInstanceProfile"]
  }

  statement {
    sid       = "AllowAPIServerEndpointDiscovery"
    resources = ["arn:${local.partition}:eks:${var.aws_region}:${var.aws_account_id}:cluster/${var.eks_cluster}"]
    actions   = ["eks:DescribeCluster"]
  }

  # SQS permissions for spot interruption handling
  dynamic "statement" {
    for_each = var.enable_spot_termination ? [1] : []
    content {
      sid       = "AllowInterruptionQueueActions"
      resources = [aws_sqs_queue.interruption[0].arn]
      actions = [
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes",
        "sqs:GetQueueUrl",
        "sqs:ReceiveMessage"
      ]
    }
  }

  dynamic "statement" {
    for_each = var.iam_policy_statements

    content {
      sid           = try(statement.value.sid, null)
      actions       = try(statement.value.actions, null)
      not_actions   = try(statement.value.not_actions, null)
      effect        = try(statement.value.effect, null)
      resources     = try(statement.value.resources, null)
      not_resources = try(statement.value.not_resources, null)

      dynamic "principals" {
        for_each = try(statement.value.principals, [])

        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "not_principals" {
        for_each = try(statement.value.not_principals, [])

        content {
          type        = not_principals.value.type
          identifiers = not_principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = try(statement.value.conditions, [])

        content {
          test     = condition.value.test
          values   = condition.value.values
          variable = condition.value.variable
        }
      }
    }
  }
}

module "karpenter_role" {
  source = "git@github.com:powise/terraform-modules//eks/irsa?ref=eks-irsa-2.1.0"

  eks_clusters = [var.eks_cluster]

  iam_role_name = "karpenter-${var.eks_cluster}-${var.aws_region}"
  iam_policy_documents = {
    "karpenter-${var.eks_cluster}-${var.aws_region}-policy" = data.aws_iam_policy_document.karpenter.json
  }

  namespace        = var.karpenter_namespace
  service_accounts = ["karpenter"]

  tags = var.tags
}
