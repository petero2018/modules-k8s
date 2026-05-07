variable "name" {
  type = string

  description = "Name of the HAProxy installation."

  validation {
    condition     = length(var.name) > 6 && substr(var.name, 0, 6) == "proxy-"
    error_message = "Installation must be named proxy-<something>."
  }
}

variable "namespace" {
  type = string

  description = "Namespace where we will deploy the proxy."
}

variable "backend" {
  type = string

  default     = "istio-ingressgateway:443"
  description = "Backend service to route traffic into."
}

variable "replicas" {
  type = number

  default     = 2
  description = "Spin this number of HAProxy pods in the beginning."
}

variable "min_replicas" {
  type = number

  default     = 2
  description = "Min number of HAProxy pods."
}

variable "max_replicas" {
  type = number

  default     = 8
  description = "Max number of HAProxy pods."
}

variable "timeouts" {
  type = object({ create = string, update = string, delete = string })

  default     = ({ create = "20m", update = "20m", delete = "10m" })
  description = "Timeouts for create/update/delete deployment operations."
}

variable "haproxy_config" {
  type = object({
    tune_bufsize = number
  })

  default = {
    tune_bufsize = 16384
  }

  description = "Customizable HAProxy settings."

  validation {
    condition     = var.haproxy_config.tune_bufsize >= 16384
    error_message = "HAProxy \"tune.bufsize\" should be 16384 or higher."
  }
}

variable "block_indexing" {
  type        = bool
  default     = false
  description = "Block indexing from search engine bots, by adding the X-Robots-Tag header to all responses."
}

variable "strip_baggage" {
  type        = bool
  default     = true
  description = "Strip baggage header from incoming requests, to prevent baggage injection from external calls."
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
