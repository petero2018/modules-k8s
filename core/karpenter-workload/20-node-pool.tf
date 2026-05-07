resource "kubernetes_manifest" "default_nodepool" {
  for_each = var.eks_auto_mode ? tomap({}) : var.karpenter_config

  manifest = {
    apiVersion = "karpenter.sh/v1"
    kind       = "NodePool"
    metadata = {
      name = each.key
    }
    spec = {
      limits = {
        cpu    = each.value.nodepool_config.limits.cpu
        memory = each.value.nodepool_config.limits.memory
      }
      disruption = {
        consolidationPolicy = each.value.nodepool_config.consolidation_policy
        consolidateAfter    = each.value.nodepool_config.consolidation_period
        budgets             = each.value.nodepool_config.node_disruption_budgets
      }
      template = {
        metadata = {
          labels = each.value.nodepool_config.labels
        }
        spec = {
          nodeClassRef = {
            group = "karpenter.k8s.aws"
            name  = each.key
            kind  = "EC2NodeClass"
          }
          taints = each.value.nodepool_config.taints
          requirements = [
            {
              key      = "kubernetes.io/arch"
              operator = "In"
              values   = each.value.nodepool_config.architecture
            },
            {
              key      = "kubernetes.io/os"
              operator = "In"
              values   = each.value.nodepool_config.os
            },
            {
              key      = "karpenter.k8s.aws/instance-family"
              operator = "In"
              values   = each.value.nodepool_config.instance_family
            },
            {
              key      = "karpenter.k8s.aws/instance-cpu"
              operator = "In"
              values   = each.value.nodepool_config.instance_cpu
            },
            {
              key      = "karpenter.sh/capacity-type"
              operator = "In"
              values   = each.value.nodepool_config.capacity_type
            },
            {
              key      = "karpenter.k8s.aws/instance-generation"
              operator = "Gt"
              values   = each.value.nodepool_config.instance_generation
            }
          ]
          expireAfter = each.value.nodepool_config.expire_after
        }
      }
    }
  }

  field_manager {

    # force field manager conflicts to be overridden
    force_conflicts = true
  }

  depends_on = [kubernetes_manifest.default_nodeclass]
}

resource "kubernetes_manifest" "default_nodepool_auto_mode" {
  for_each = var.eks_auto_mode ? var.karpenter_config : tomap({})

  manifest = {
    apiVersion = "karpenter.sh/v1"
    kind       = "NodePool"
    metadata = {
      name = each.key
    }
    spec = {
      limits = {
        cpu    = each.value.nodepool_config.limits.cpu
        memory = each.value.nodepool_config.limits.memory
      }
      disruption = {
        consolidationPolicy = each.value.nodepool_config.consolidation_policy
        consolidateAfter    = each.value.nodepool_config.consolidation_period
        budgets             = each.value.nodepool_config.node_disruption_budgets
      }
      template = {
        metadata = {
          labels = each.value.nodepool_config.labels
        }
        spec = {
          nodeClassRef = {
            group = "eks.amazonaws.com"
            name  = each.key
            kind  = "NodeClass"
          }
          taints = each.value.nodepool_config.taints
          requirements = [
            {
              key      = "kubernetes.io/arch"
              operator = "In"
              values   = each.value.nodepool_config.architecture
            },
            {
              key      = "eks.amazonaws.com/instance-family"
              operator = "In"
              values   = each.value.nodepool_config.instance_family
            },
            {
              key      = "eks.amazonaws.com/instance-cpu"
              operator = "In"
              values   = each.value.nodepool_config.instance_cpu
            },
            {
              key      = "karpenter.sh/capacity-type"
              operator = "In"
              values   = each.value.nodepool_config.capacity_type
            },
            {
              key      = "eks.amazonaws.com/instance-generation"
              operator = "Gt"
              values   = each.value.nodepool_config.instance_generation
            }
          ]
          expireAfter = each.value.nodepool_config.expire_after
        }
      }
    }
  }

  field_manager {
    # force field manager conflicts to be overridden
    force_conflicts = true
  }

  depends_on = [kubernetes_manifest.default_nodeclass]
}
