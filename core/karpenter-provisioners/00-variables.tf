################################################################################
# EKS Cluster
################################################################################

variable "eks_cluster" {
  description = "Cluster Name"
  type        = string
}

variable "k8s_version" {
  description = "Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.21`)"
  type        = string
  default     = null

  validation {
    condition     = length(split(".", var.k8s_version)) == 2
    error_message = "Kubernetes version should be `<major>.<minor>`."
  }
}

variable "eks_cluster_endpoint" {
  description = "EKS cluster endpoint."
  type        = string
}

variable "eks_cluster_auth_base64" {
  description = "Base64 encoded CA of associated EKS cluster"
  type        = string
}

variable "cluster_security_group_id" {
  type        = string
  description = "ID of the cluster security group."
}

variable "workers_security_group_id" {
  type        = string
  description = "ID of the security group for the worker nodes."
}

################################################################################
# Karpenter Profile
################################################################################

variable "instance_profile_arn" {
  description = "Instance profile ARN to add to the launch template."
  type        = string
  default     = null

  validation {
    condition     = var.instance_profile_arn == null || can(regex("arn:aws:iam::[0-9]{12}:instance-profile/.+", var.instance_profile_arn))
    error_message = "Invalid instance profile ARN."
  }
}

################################################################################
# Startup protection
################################################################################

variable "startup_taints" {
  description = "Temporary taints to be applied, after node is initialized they're deleted."
  type = list(object({
    key    = string,
    value  = string,
    effect = string
  }))
  default = []

  validation {
    condition = alltrue([
      for t in var.startup_taints : contains(["NoSchedule", "NoExecute", "PreferNoSchedule"], t.effect)
    ])
    error_message = "Illegal selector for the security group policy."
  }
}

################################################################################
# Provisioners
################################################################################

variable "registry_mirrors" {
  description = "Enables image registry mirror to avoid dockerhub limits. Only available for bottlerocket."
  type        = list(string)
  default     = []
}

variable "provisioner_enable_spot" {
  description = "Enable Spot Provisioners. Creates a spot version of each provisioner."
  type        = bool
  default     = true
}

variable "provisioners" {
  description = "Karpenter Provisioners"
  type = map(object({
    use_spot              = optional(bool)
    architecture          = optional(string)
    gpu_support           = optional(bool)
    platform              = optional(string)
    key_name              = optional(string)
    seconds_after_empty   = optional(number)
    seconds_until_expired = optional(number)
    requirements = list(object({
      key : string
      operator : string
      values : list(string)
    }))
    block_device_mappings = optional(list(object({
      device_name : string
      no_device : optional(string)
      virtual_name : optional(string)
      ebs : list(object({
        kms_key_id : optional(string)
        iops : optional(number)
        throughput : optional(number)
        snapshot_id : optional(string)
        volume_size : number
        volume_type : string
      }))
    })))
    limit_cpu    = optional(string)
    limit_memory = optional(string)
    node_labels  = optional(map(string))
    taints = optional(list(object({
      key    = string,
      value  = string,
      effect = string
    })))
    node_tags = optional(map(string))
  }))
  default = {}
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "Tags to be applied to resources."
  type        = map(string)
}
