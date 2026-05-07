################################################################################
# External Secret
################################################################################

variable "name" {
  type = string

  description = "External Secret name."
}

variable "secret_name" {
  type = string

  default     = null
  description = "Kubernetes Secret Name. Keep it unset to default to name."
}

variable "namespace" {
  type = string

  description = "Namespace where to create the secret."
}

variable "refresh_interval" {
  type = string

  default     = "1h"
  description = "amount of time before the values reading again from the SecretStore."
}

variable "creation_policy" {
  type = string

  default     = "Owner"
  description = "Values: Owner creates the secret, Merge does not create the secret."

  validation {
    condition     = contains(["Owner", "Merge"], var.creation_policy)
    error_message = "Valid Creation Policy required: Owner, Merge."
  }
}

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
  type = map(object({
    key      = string
    property = optional(string)
    version  = optional(string)
  }))

  description = "Secrets to retrieve from SecretManager or ParameterStore."
}

################################################################################
# Secret Store
################################################################################

variable "secret_store_name" {
  type = string

  default     = null
  description = "AWS Secret Store Name."
}

variable "create_secret_store" {
  type = bool

  default     = true
  description = "Flag to create the secret store needed for this secret."
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
