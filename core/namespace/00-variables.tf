variable "name" {
  type = string

  description = "Name of the namespace."
}

variable "namespace_type" {
  type = string

  default     = "normal"
  description = "Is this namespace normal, ephemeral, or ... ?"

  validation {
    condition     = contains(["normal", "ephemeral"], var.namespace_type)
    error_message = "Unsupported namespace type!"
  }
}

variable "enable_istio" {
  type = bool

  default     = false
  description = "Enable istio service mesh? (sets \"istio-injection\" label)"
}

variable "rbac_users" {
  type        = list(string)
  description = "List of users allowed to enumerate resources in this namespace."
}

variable "rbac_users_readonly" {
  type        = bool
  description = "Are RBAC users limited to read-only actions only?"
}

variable "rbac_groups" {
  type        = list(string)
  description = "List of groups allowed to enumerate resources in this namespace."
}

variable "rbac_groups_readonly" {
  type        = bool
  description = "Are RBAC groups limited to read-only actions only?"
}

variable "enable_common_credentials" {
  type = bool

  default     = true
  description = "Make common [image pull] credentials available as a Kubernetes secret."
}

variable "registry_cred_helpers" {
  type = map(string)

  default = {
    "public.ecr.aws" : "ecr-login"
    "567716553783.dkr.ecr.us-east-1.amazonaws.com" : "ecr-login"
    "495154853931.dkr.ecr.us-east-1.amazonaws.com" : "ecr-login"
    "695900824579.dkr.ecr.us-east-1.amazonaws.com" : "ecr-login"
  }

  description = "Configure following helpers for the registries specified."
}

variable "external_registry_auths" {
  type = map(string)

  default = {}

  description = "Map of <external (non-ECR) registry>:<ssm secret key with registry auth> form to be included in common [image pull] credentials."
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Labels to apply to the kubernetes namespace."
}
