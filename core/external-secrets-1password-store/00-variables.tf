################################################################################
# External Secrets 1Password Store
################################################################################

variable "name" {
  type = string

  default     = "1password"
  description = "Name of the Secret Store"
}

variable "store_type" {
  type = string

  default     = "ClusterSecretStore"
  description = "Store type to create: SecretStore (to be namespaced), ClusterSecretStore (to be used cluster scoped)"

  validation {
    condition     = contains(["ClusterSecretStore", "SecretStore"], var.store_type)
    error_message = "Valid Store type required: ClusterSecretStore, SecretStore."
  }
}

variable "namespace" {
  type = string

  default     = null
  description = "Namespace to use if the store type is namespaced."
}

################################################################################
# 1Password Config
################################################################################

variable "connect_url" {
  type = string

  default     = "http://onepassword-connect:8080"
  description = "URL of the 1password connect service"
}

variable "access_token_ssm_path" {
  type = string

  description = "SSM parameter with 1password access token"
}

variable "secret_namespace" {
  type = string

  default     = "kube-system"
  description = "Where to store the 1Password secrets."
}

variable "vaults" {
  type = list(string)

  description = "1Password vaults to grant access to external secrets operator store"
}

################################################################################
# Wait for Store creation
################################################################################

variable "wait" {
  description = "Will wait until secret store is created and sync successfully."
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
