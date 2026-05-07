################################################################################
# External Secrets AWS Store
################################################################################

variable "name" {
  type = string

  description = "Name of the Secret Store"
}

variable "namespace" {
  type = string

  description = "Namespace where to create the Secret Store."
}

################################################################################
# IRSA
################################################################################

variable "create_irsa" {
  type = bool

  default     = true
  description = "Creates IRSA for the Secret Store."
}

variable "eks_cluster" {
  description = "Name of the EKS cluster to deploy into."
  default     = null
  type        = string
}

variable "service_account" {
  type = string

  default     = null
  description = "service account name to use for the Secret Store"
}

################################################################################
# Service Access
################################################################################

variable "aws_service" {
  type = string

  default     = "SecretsManager"
  description = "Service to allow access."

  validation {
    condition     = contains(["SecretsManager", "ParameterStore"], var.aws_service)
    error_message = "Valid AWS service required: SecretsManager, ParameterStore."
  }
}

variable "aws_region" {
  type = string

  default     = null
  description = "AWS Region to grant access."
}

variable "secrets" {
  type = list(string)

  default     = []
  description = "SSM Parameters or AWS Secrets to grant access."
}

################################################################################
# Wait for secret creation
################################################################################

variable "wait" {
  description = "Will wait until secret is created and sync successfully."
  type        = bool
  default     = false
}

variable "timeout" {
  description = "Time in seconds to wait for secret creation."
  type        = number
  default     = 60
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
