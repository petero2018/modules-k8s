################################################################################
# External Secrets 1Password Secret
################################################################################

variable "name" {
  type = string

  description = "External Secret Name"
}

variable "secret_name" {
  type = string

  default     = null
  description = "Kubernetes Secret Name. Keep it unset to default to name."
}

variable "namespace" {
  type = string

  description = "Namespace where to create the secret"
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

variable "secrets" {
  type = map(object({
    key      = string
    property = string
  }))

  description = "Secrets to retrieve from 1password."
}

################################################################################
# Secret Store
################################################################################

variable "secret_store_name" {
  type = string

  default     = "1password"
  description = "Secret Store Name."
}

variable "secret_store_type" {
  type = string

  default     = "ClusterSecretStore"
  description = "Store type to create: SecretStore (to be namespaced), ClusterSecretStore (to be used cluster scoped)"

  validation {
    condition     = contains(["ClusterSecretStore", "SecretStore"], var.secret_store_type)
    error_message = "Valid Store type required: ClusterSecretStore, SecretStore."
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

variable "eks_cluster" {
  description = "EKS cluster name, needed to wait resource creation."
  default     = null
  type        = string
}
