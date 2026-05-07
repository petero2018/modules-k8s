variable "istio_version" {
  type = string

  description = "istio version to install."

  validation {
    condition     = can(regex("^1\\.[0-9]+\\.[0-9]+$", var.istio_version))
    error_message = "Invalid version format."
  }
}

variable "hold_application" {
  type = bool

  description = "Wait for Envoy to become ready before starting app containers (default behavior, may be overriden per-pod with annotations)."
  default     = true
}

variable "include_ip_ranges" {
  type = list(string)

  description = "Capture egress traffic on those IP Ranges (empty list means capture all)."
  default     = []

  validation {
    condition = alltrue([
      for ip_range in var.include_ip_ranges : cidrsubnet(ip_range, 0, 0) == ip_range
    ])
    error_message = "Invalid CIDR specification."
  }
}

variable "exclude_outbound_ports" {
  type = list(number)

  description = "Don't capture egress traffic on those ports."
  default     = []
}

variable "preserve_external_request_id" {
  type = bool

  description = "Preserve the value of \"X-Request-Id\" header set on the upstream instead of [re]setting it."
  default     = false
}

variable "use_xds_v2_api" {
  type = bool

  description = "Use xDS v2 API for Envoy configuration. This is required for older versions of Istio."
  default     = false
}

variable "enable_legacy_fsgroup_injection" {
  type = bool

  description = "If true (default), Istiod will set the pod fsGroup to 1337 on injection. This is required for Kubernetes 1.18 and older."
  default     = true
}

variable "hub" {
  type = string

  description = "Container registry hub."
  default     = null
}

variable "sidecar_requests" {
  type = object({ cpu = string, memory = string })

  description = "Resource requests of the sidecar proxy container."

  default = { cpu = "250m", memory = "512Mi" }
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

variable "capacity_type_selector" {
  type = object({
    key   = optional(string, "eks\\.amazonaws\\.com/capacityType")
    value = optional(string, "ON_DEMAND")
  })

  description = "The key and value used for the nodeSelector for Istio control plane components."
}

variable "install_egress_gateway" {
  type        = bool
  default     = true
  description = "Whether to install the egress gateway."
}
