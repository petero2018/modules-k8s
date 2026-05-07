################################################################################
# EKS Cluster
################################################################################

variable "eks_cluster" {
  description = "Name of the EKS cluster to deploy into."
  type        = string
}

variable "aws_region" {
  description = "Region name where the cluster is running. This is used for IAM roles naming."
  type        = string
  default     = ""
}

################################################################################
# EBS CSI
################################################################################

variable "ebs_csi_version" {
  description = "\"EBS CSI\" EKS addon version."
  type        = string
}

variable "kms_encryption_keys" {
  description = "Custom KMS encryption key to use for EBS volumes."
  type        = list(string)
  default     = []
}

variable "delete_default" {
  description = "Deletes default created storage class."
  type        = bool
  default     = false
}

variable "configuration_values" {
  type    = string
  default = null

  description = "Custom add-on configuration."
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "Tags to be applied to AWS resources."
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
