variable "addon_name" {
  type = string

  description = "istio addon name to install"

  validation {
    condition     = contains(["grafana", "kiali", "prometheus"], var.addon_name)
    error_message = "Unknown addon name."
  }
}

variable "deploy_arch" {
  type        = string
  description = "Node architecture to deploy to. Must be either \"amd64\" or \"arm64\""
  default     = "amd64"

  validation {
    condition     = contains(["amd64", "arm64"], var.deploy_arch)
    error_message = "Valid values for node architecture are: (amd64, arm64)"
  }
}
