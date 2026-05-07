variable "namespace" {
  type        = string
  description = "Kubernetes namespace to install this chart release into."
}

variable "chart_version" {
  type        = string
  description = "A version of Flagger Helm chart we want to install."
}

variable "chart_timeout" {
  type = number

  default     = 600
  description = "Helm chart installation timeout in seconds."
}

variable "rbac_users" {
  type        = list(string)
  description = "List of users allowed to enumerate resources in flagger namespace."
}

variable "rbac_users_readonly" {
  type        = bool
  description = "Are RBAC users limited to read-only actions only?"
}

variable "rbac_groups" {
  type        = list(string)
  description = "List of groups allowed to enumerate resources in flagger namespace."
}

variable "rbac_groups_readonly" {
  type        = bool
  description = "Are RBAC groups limited to read-only actions only?"
}

variable "datadog_api_key" {
  type        = string
  sensitive   = true
  default     = null
  description = "Datadog API key."
}

variable "datadog_app_key" {
  type        = string
  sensitive   = true
  default     = null
  description = "Datadog application key."
}

variable "flagger_request_memory" {
  type = string

  default     = "200m"
  description = "resources.requests.memory for Flagger's k8s operator"
}

variable "flagger_request_cpu" {
  type = string

  default     = "200m"
  description = "resources.requests.cpu for Flagger's k8s operator"
}

variable "deploy_arch" {
  type        = string
  description = "Node architecture to deploy to. Must be either \"amd64\" or \"arm64\""
  default     = "arm64"

  validation {
    condition     = contains(["amd64", "arm64"], var.deploy_arch)
    error_message = "Valid values for node architecture are: (amd64, arm64)"
  }
}
