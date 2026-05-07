locals {
  # Architecture Requirement
  architecture_requirement = [
    {
      key      = "kubernetes.io/arch"
      operator = "In"
      values   = [var.architecture]
    }
  ]
  # Capacity Type Requirement
  capacity_requirement = [
    {
      key      = "karpenter.sh/capacity-type"
      operator = "In"
      values   = var.use_spot ? ["spot"] : ["on-demand"]
    }
  ]
  # Requirements
  spec_requirements = {
    "requirements" = concat(
      local.architecture_requirement,
      local.capacity_requirement,
      var.requirements
    )
  }

  # Provider Instance Profile
  provider_instance_profile = var.use_launch_template ? {} : {
    # Grab the instance profile name from the ARN
    instanceProfile = try(reverse(split("/", var.instance_profile_arn))[0], null)
  }
  # Provider launch template
  provider_launch_template = var.use_launch_template ? var.create_launch_template ? {
    launchTemplate = module.launch_template[0].name
    } : {
    launchTemplate = var.launch_template_name
  } : {}
  # Provider Subnet Selector
  provider_subnet_selector = {
    subnetSelector = {
      "karpenter.sh/discovery/${var.eks_cluster}" = "network"
    }
  }
  # Provider Security Group Selector
  provider_security_group_selector = var.use_launch_template ? {} : {
    securityGroupSelector = {
      "karpenter.sh/discovery/${var.eks_cluster}" = "network"
    }
  }
  # Tags to apply to the nodes
  provider_tags = {
    tags = var.node_tags
  }
  # Spec Provider
  spec_provider = {
    provider = merge(
      {
        "apiVersion" = "extensions.karpenter.sh/v1alpha1"
        "kind"       = "AWS"
      },
      local.provider_instance_profile,
      local.provider_launch_template,
      local.provider_security_group_selector,
      local.provider_subnet_selector,
      local.provider_tags
    )
  }

  # Spec Seconds until expired
  spec_seconds_until_expired = var.seconds_until_expired != null ? {
    ttlSecondsUntilExpired = var.seconds_until_expired
  } : {}
  # Spec Seconds after empty or consolidation
  spec_consolidation = var.enable_consolidation ? {
    consolidation = {
      enabled = true
    }
  } : {}
  spec_seconds_after_empty = var.enable_consolidation ? {} : {
    ttlSecondsAfterEmpty = var.seconds_after_empty
  }
  # Spec taints
  spec_taints = length(var.taints) > 0 ? {
    taints = var.taints
  } : {}
  # Spec startup taints
  spec_startup_taints = length(var.startup_taints) > 0 ? {
    startupTaints = var.startup_taints
  } : {}
  # Spec Labels
  spec_labels = length(var.node_labels) > 0 ? {
    labels = var.node_labels
  } : {}
  # Spec Kubelet Configuration
  spec_kubelet_config = length(var.kubelet_config) > 0 ? {
    kubeletConfiguration = var.kubelet_config
  } : {}
  # Spec Limits
  spec_limits = {
    limits = {
      resources = {
        cpu    = var.limit_cpu
        memory = var.limit_memory
      }
    }
  }

  # Spec
  spec = merge(
    local.spec_kubelet_config,
    local.spec_labels,
    local.spec_limits,
    local.spec_provider,
    local.spec_requirements,
    local.spec_seconds_after_empty,
    local.spec_seconds_until_expired,
    local.spec_consolidation,
    local.spec_startup_taints,
    local.spec_taints
  )
}

resource "kubernetes_manifest" "provisioner" {
  # https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest#computed-fields
  computed_fields = ["spec", "metadata.labels"]
  manifest = {
    "apiVersion" = "karpenter.sh/v1alpha5"
    "kind"       = "Provisioner"
    "metadata" = {
      "name"        = var.provisioner_name
      "labels"      = var.labels
      "annotations" = local.annotations
    }
    "spec" = local.spec
  }
}
