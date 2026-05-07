variable "vpc_cni_version" {
  type = string

  # See https://docs.aws.amazon.com/eks/latest/userguide/managing-vpc-cni.html
  default     = "v1.16.4-eksbuild.2"
  description = "\"VPC CNI\" EKS addon version."
}

variable "vpc_cni_chart_version" {
  type = string

  default     = "1.1.10"
  description = "\"VPC CNI\" EKS addon helm chart version."
}

variable "enable_security_group_policies" {
  type = bool

  default     = false
  description = "Enable security group policies (set \"true\" to support security groups for pods)."
}

variable "eks_cluster" {
  type = string

  description = "Name of the EKS cluster to deploy into."

  validation {
    condition     = length(split("-", var.eks_cluster)) == 2
    error_message = "Cluster name should be passed in ENV-CLUSTER form."
  }
}

variable "configuration_values" {
  type    = string
  default = null

  description = "Custom add-on configuration."
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to resources."
  validation {
    condition = alltrue([
      contains(keys(var.tags), "team"),
      contains(keys(var.tags), "service"),
      contains(keys(var.tags), "impact"),
    ])
    error_message = "Required tags are missing! Please provide tags 'team', 'service' and 'impact'."
  }
}
