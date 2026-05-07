data "aws_eks_cluster" "cluster" {
  name = var.eks_cluster
}

locals {
  # Check if we're using EKS 1.33 or newer (which requires AL2023)
  use_al2023 = tonumber(replace(data.aws_eks_cluster.cluster.version, ".", "")) >= 133

  # Define AMI paths based on EKS version
  arm_ami_path = local.use_al2023 ? "/amazon-linux-2023/arm64/standard" : "/amazon-linux-2-arm64"
  amd_ami_path = local.use_al2023 ? "/amazon-linux-2023/x86_64/standard" : "/amazon-linux-2"
}

data "aws_ssm_parameter" "arm_ami_id" {
  name = "/aws/service/eks/optimized-ami/${data.aws_eks_cluster.cluster.version}${local.arm_ami_path}/recommended/image_id"
}

data "aws_ssm_parameter" "amd_ami_id" {
  name = "/aws/service/eks/optimized-ami/${data.aws_eks_cluster.cluster.version}${local.amd_ami_path}/recommended/image_id"
}

resource "kubernetes_manifest" "default_nodeclass" {
  for_each = var.eks_auto_mode ? tomap({}) : var.karpenter_config

  manifest = {
    apiVersion = "karpenter.k8s.aws/v1"
    kind       = "EC2NodeClass"
    metadata = {
      name = each.key
    }
    spec = {
      amiFamily = local.use_al2023 ? "AL2023" : "AL2"
      role      = var.worker_role_name

      subnetSelectorTerms = [{
        tags = {
          "karpenter.sh/discovery/${var.eks_cluster}" = "network"
        }
      }]
      securityGroupSelectorTerms = concat(
        [
          # In order to pick up the security group created by EKS, we need to use
          # Two separate tags selectors. This results in an OR operation between the two.
          {
            tags = {
              "karpenter.sh/discovery/${var.eks_cluster}" = "network"
            }
          },
          {
            tags = {
              "kubernetes.io/cluster/${var.eks_cluster}" = "owned"
            }
          }
        ],
        each.value.extra_security_groups_selectors,
      )
      amiSelectorTerms = [
        { id = data.aws_ssm_parameter.arm_ami_id.value },
        { id = data.aws_ssm_parameter.amd_ami_id.value }
      ]

      blockDeviceMappings = each.value.block_device_mappings
      detailedMonitoring  = true
      metadataOptions = {
        httpPutResponseHopLimit = 2
        httpEndpoint            = "enabled"
        httpTokens              = "required"
      }
      tags = {
        "karpenter.sh/discovery"                    = var.eks_cluster
        "karpenter.sh/discovery/${var.eks_cluster}" = "owned"
      }
    }
  }

  field_manager {
    # force field manager conflicts to be overridden
    force_conflicts = true
  }

}

resource "kubernetes_manifest" "default_nodeclass_auto_mode" {
  for_each = var.eks_auto_mode ? var.karpenter_config : tomap({})

  manifest = {
    apiVersion = "eks.amazonaws.com/v1"
    kind       = "NodeClass"
    metadata = {
      name = each.key
    }
    spec = merge(
      {
        role = var.worker_role_name

        subnetSelectorTerms = [{
          tags = {
            "kubernetes.io/role/internal-elb" = "1"                 # Private Subnets only
            "vpc-name"                        = each.value.vpc_name # Select the appropriate VPC
          }
        }]
        securityGroupSelectorTerms = concat(
          [
            {
              tags = {
                "Name" = "eks-workers-${var.eks_cluster}"
              }
            },
            {
              tags = {
                "aws:eks:cluster-name" = var.eks_cluster
              }
            },
          ],
          each.value.extra_security_groups_selectors,
        )

        tags = {
          "Name"                                        = "${each.key}-${var.eks_cluster}"
          "karpenter.sh/discovery"                      = var.eks_cluster
          ("karpenter.sh/discovery/${var.eks_cluster}") = "owned"
        }
      },
      # Make block device mapping optional
      try(length(each.value.block_device_mappings), 0) > 0 ? {
        ephemeralStorage = {
          size       = each.value.block_device_mappings[0].ebs.volumeSize
          iops       = each.value.block_device_mappings[0].ebs.iops
          throughput = each.value.block_device_mappings[0].ebs.throughput
        }
      } : {}
    )
  }

  field_manager {
    # force field manager conflicts to be overridden
    force_conflicts = true
  }
}
