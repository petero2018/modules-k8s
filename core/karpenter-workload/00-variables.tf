variable "eks_cluster" {
  type = string

  description = "Name of the EKS cluster to deploy into."
}

variable "worker_role_name" {
  type = string

  description = "IAM role name to use for the node identity. The \"role\" field is immutable after EC2NodeClass creation."
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to AWS resources."

  validation {
    condition = alltrue([
      contains(keys(var.tags), "team"),
      contains(keys(var.tags), "service"),
      contains(keys(var.tags), "impact"),
    ])
    error_message = "Required tags are missing! Please provide tags 'team', 'service' and 'impact'."
  }
}

variable "karpenter_config" {
  type = map(object({
    vpc_name = optional(string, "eks") # Used in EKS Auto Mode to target the proper subnets
    block_device_mappings = optional(list(object({
      deviceName = optional(string, "/dev/xvda")
      ebs = optional(object({
        volumeSize          = optional(string, "100Gi")
        volumeType          = optional(string, "gp3")
        iops                = optional(number, 3000)
        throughput          = optional(number, 125)
        encrypted           = optional(bool, true)
        key                 = optional(string, "")
        deleteOnTermination = optional(bool, true)
      }))
    })))
    extra_security_groups_selectors = optional(list(object({ tags = map(string) })), [])
    nodepool_config = optional(object({
      architecture         = optional(list(string), ["arm64", "amd64"])
      os                   = optional(list(string), ["linux"])
      instance_family      = optional(list(string), ["c7g", "m5", "m7g"])
      instance_cpu         = optional(list(string), ["4", "8", "16"])
      instance_generation  = optional(list(string), ["2"])
      capacity_type        = optional(list(string), ["on-demand"])
      consolidation_policy = optional(string, "WhenEmptyOrUnderutilized")
      consolidation_period = optional(string, "30s")
      expire_after         = optional(string, "720h")
      limits = optional(object({
        cpu    = optional(string, "50")
        memory = optional(string, "50Gi")
      }))
      labels = optional(map(string), {})
      taints = optional(list(object({
        key    = string,
        value  = string,
        effect = string
      })), null)
      node_disruption_budgets = optional(list(object({
        nodes    = optional(string, "10%")
        schedule = optional(string)
        duration = optional(string)
        reasons  = optional(list(string))
      })))
    }))
  }))

  description = "Karpenter worload configuration."
}

variable "eks_auto_mode" {
  type        = bool
  default     = false
  description = "Use EKS Auto Mode CRDs instead of default Karpenter ones."
}
