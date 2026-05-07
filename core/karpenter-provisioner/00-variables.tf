################################################################################
# EKS Cluster
################################################################################

variable "eks_cluster" {
  description = "Name of the EKS cluster to deploy into."
  type        = string
}

variable "eks_cluster_endpoint" {
  description = "EKS cluster endpoint."
  default     = ""
  type        = string
}

variable "eks_cluster_auth_base64" {
  description = "Base64 encoded CA of associated EKS cluster"
  type        = string
  default     = ""
}

variable "eks_cluster_service_ipv4_cidr" {
  description = "The CIDR block to assign Kubernetes service IP addresses from. If you don't specify a block, Kubernetes assigns addresses from either the 10.100.0.0/16 or 172.20.0.0/16 CIDR blocks"
  type        = string
  default     = null
}

################################################################################
# Karpenter
################################################################################

variable "provisioner_name" {
  description = "Name of the Karpenter provisioner."
  type        = string
}

variable "instance_profile_arn" {
  description = "Instance profile ARN to add to the launch template."
  type        = string
  default     = null

  validation {
    condition     = var.instance_profile_arn == null || can(regex("arn:aws:iam::[0-9]{12}:instance-profile/.+", var.instance_profile_arn))
    error_message = "Invalid instance profile ARN."
  }
}

variable "requirements" {
  description = "Karpenter Requirements."
  type = list(object({
    key : string
    operator : string
    values : list(string)
  }))
  default = []
}

variable "architecture" {
  description = "Identifies the architecture."
  type        = string
  default     = "amd64"

  validation {
    condition     = contains(["amd64", "arm64"], var.architecture)
    error_message = "Invalid architecture type! Valid values: 'amd64' and 'arm64'."
  }
}

variable "gpu_support" {
  description = "Identifies if the IAM needs GPU support."
  type        = bool
  default     = false
}

variable "kubelet_config" {
  description = "Additional kubelet configurations to be applied."
  type        = map(string)
  default     = {}
}

variable "use_spot" {
  description = "Enable spot instances. This will allow the cluster to use spot instances when available."
  type        = bool
  default     = false
}

variable "limit_cpu" {
  description = "CPU limit for the provisioner."
  type        = string
  default     = "100"
}

variable "limit_memory" {
  description = "Memory limit for the provisioner."
  type        = string
  default     = "100Gi"
}

variable "node_labels" {
  description = "Labels to be applied to the created nodes."
  type        = map(string)
  default     = {}
}

variable "taints" {
  description = "The Kubernetes taints to be applied to the nodes created by this provisioner."
  type = list(object({
    key    = string,
    value  = string,
    effect = string
  }))
  default = []

  validation {
    condition = alltrue([
      for t in var.taints : contains(["NoSchedule", "NoExecute", "PreferNoSchedule"], t.effect)
    ])
    error_message = "Illegal selector for the security group policy."
  }
}

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

variable "seconds_after_empty" {
  description = "Setting a value here enables Karpenter to delete empty/unnecessary instances."
  type        = number
  default     = 30
}

variable "seconds_until_expired" {
  description = "Setting a value here enables node expiry. This enables nodes to effectively be periodically “upgraded” by replacing them with newly provisioned instances."
  type        = number
  default     = null
}

variable "enable_consolidation" {
  description = "Requires Karpenter v0.15+. Whether to enable consolidation of worker nodes. This will cause the module to ignore the value of `seconds_after_empty` as these options are mutually exclusive."
  type        = bool
  default     = false
}

variable "node_tags" {
  description = "Tags to be applied to created nodes by karpenter."
  type        = map(string)
  default     = {}
}

################################################################################
# Launch template
################################################################################

variable "use_launch_template" {
  description = "Whether to use a launch template on the Provisioner"
  type        = bool
  default     = true
}

variable "create_launch_template" {
  description = "Whether to create a new launch template or use one already created."
  type        = bool
  default     = true
}

variable "launch_template_name" {
  description = "Name of the launch template. If no one is specified it will use the group name as prefix."
  type        = string
  default     = null
}

variable "platform" {
  description = "Identifies if the OS platform is `bottlerocket` or `linux` based;"
  type        = string
  default     = "linux"

  validation {
    condition     = contains(["linux", "bottlerocket"], var.platform)
    error_message = "Invalid platform type! Valid values: 'linux' and 'bottlerocket'."
  }
}

variable "k8s_version" {
  description = "The K8S version of the cluster. Mandatory if `use_aws_ami` is defined."
  type        = string
  default     = ""
}

variable "ami_id" {
  description = "The AMI from which to launch the instance. If not supplied, EKS will use its own default image"
  type        = string
  default     = null
}

variable "key_name" {
  description = "Key Pair to use for the instance"
  type        = string
  default     = null
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance(s) will be EBS-optimized"
  type        = bool
  default     = null
}

variable "cluster_security_group_id" {
  type        = string
  description = "ID of the cluster security group."
}

variable "workers_security_group_id" {
  type        = string
  description = "ID of the security group for the worker nodes."
}

variable "additional_vpc_security_group_ids" {
  description = "A list of security group IDs to associate"
  type        = list(string)
  default     = []
}

variable "launch_template_default_version" {
  description = "Default version of the launch template"
  type        = string
  default     = null
}

variable "update_launch_template_default_version" {
  description = "Whether to update the launch templates default version on each update. Conflicts with `launch_template_default_version`"
  type        = bool
  default     = true
}

variable "block_device_mappings" {
  description = "Specify volumes to attach to the instance besides the volumes specified by the AMI"
  type = list(object({
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
  }))
  default = [
    {
      device_name : "/dev/sda1"
      ebs : [
        {
          volume_type : "gp3"
          volume_size : 100
        }
      ]
    }
  ]
}

variable "spot_max_price" {
  description = "The maximum hourly price you're willing to pay for the Spot Instances."
  type        = number
  default     = null
}

variable "enable_monitoring" {
  description = "Enables/disables detailed monitoring"
  type        = bool
  default     = true
}

variable "launch_template_tags" {
  description = "A map of additional tags to add to the tag_specifications of launch template created"
  type        = map(string)
  default     = {}
}

################################################################################
# User Data
################################################################################

variable "enable_bootstrap_user_data" {
  description = "Determines whether the bootstrap configurations are populated within the user data template"
  type        = bool
  default     = true
}

variable "pre_bootstrap_user_data" {
  description = "User data that is injected into the user data script ahead of the EKS bootstrap script. Not used when `platform` = `bottlerocket`"
  type        = string
  default     = ""
}

variable "post_bootstrap_user_data" {
  description = "User data that is appended to the user data script after of the EKS bootstrap script. Not used when `platform` = `bottlerocket`"
  type        = string
  default     = ""
}

variable "bootstrap_extra_args" {
  description = "Additional arguments passed to the bootstrap script. When `platform` = `bottlerocket`; these are additional [settings](https://github.com/bottlerocket-os/bottlerocket#settings) that are provided to the Bottlerocket user data"
  type        = string
  default     = ""
}

variable "user_data_template_path" {
  description = "Path to a local, custom user data template file to use when rendering user data"
  type        = string
  default     = ""
}

variable "registry_mirrors" {
  description = "Enables image registry mirror to avoid dockerhub limits. Only available for bottlerocket."
  type        = list(string)
  default     = []
}

################################################################################
# Tags
################################################################################

variable "labels" {
  description = "Labels to be applied to K8S resources."
  type        = map(string)
  default     = {}
}

variable "annotations" {
  description = "Annotations to be applied to K8S resources."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to be applied to resources."
  type        = map(string)

  validation {
    condition = alltrue([
      contains(keys(var.tags), "team"),
      contains(keys(var.tags), "service"),
      contains(keys(var.tags), "impact"),
    ])
    error_message = "Required tags are missing! Please provide tags 'team', 'service' and 'impact'."
  }
}
