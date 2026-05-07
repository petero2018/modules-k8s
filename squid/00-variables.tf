variable "name" {
  type = string

  description = "Name of the Squid installation."
}

variable "namespace" {
  type = string

  description = "Namespace where we will deploy Squid."
}

variable "istio_namespace" {
  type = string

  default     = "istio-system"
  description = "Namespace where we have our Istio mesh compomnents installed."
}

variable "image" {
  type = string

  default     = "ubuntu/squid:5.2-22.04_beta"
  description = "Squid container image."
}

variable "replicas" {
  type = number

  default     = 2
  description = "Spin this number of Squid pods in the beginning."
}

variable "min_replicas" {
  type = number

  default     = 2
  description = "Min number of Squid pods."
}

variable "max_replicas" {
  type = number

  default     = 8
  description = "Max number of Squid pods."
}

variable "requests" {
  type = object({ cpu = string, memory = string })

  default     = ({ cpu = "250m", memory = "256Mi" })
  description = "Squid container resource requests."
}

variable "denied_cidrs" {
  type        = list(string)
  description = "List of CIDRs with denied access to."
  default = [
    "192.168.0.0/16",
    "172.16.0.0/12",
    "10.0.0.0/8"
  ]
}

variable "pod_security_context" {
  type = object({
    fs_group = number,
  })

  default = {
    fs_group = 65534,
  }

  description = "Pod security context settings."
}

variable "container_security_context" {
  type = object({
    add_capabilities  = list(string),
    drop_capabilities = list(string),
  })

  default = {
    add_capabilities  = [],
    drop_capabilities = [],
  }

  description = "Container-level security context settings."
}

variable "run_as_non_root" {
  type        = bool
  default     = false
  description = "Needs to be true in order to run the container as a non-root user."
}

variable "run_as_user" {
  type        = string
  default     = "0"
  description = "Defines the user id that will run the container, default 0 (root)."
}

variable "run_as_group" {
  type        = string
  default     = "0"
  description = "Defines the group where the container will run, default 0."
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

variable "tolerations" {
  type = list(object({
    key      = optional(string)
    operator = optional(string)
    value    = optional(string)
    effect   = optional(string)
  }))
  default     = []
  description = "Pod tolerations."
}
