variable "name" {
  type        = string
  description = "Name of the istio ingress gateway custom resource."
}

variable "namespace" {
  type = string

  description = "Namespace to provision gateway custom resource."
}

variable "tls_secret_namespace" {
  type        = string
  default     = null
  description = "Namespace to provision TLS secrets for the gateway."
}

variable "tls_mode" {
  type        = string
  default     = "SIMPLE"
  description = "TLS mode for the gateway."
  validation {
    condition     = contains(["SIMPLE", "PASSTHROUGH", "MUTUAL", "AUTO_PASSTHROUGH", "ISTIO_MUTUAL"], var.tls_mode)
    error_message = "TLS mode for the gateway should be one of the values described here: https://istio.io/latest/docs/reference/config/networking/gateway/#ServerTLSSettings-TLSmode ."
  }
}

variable "ingress_labels" {
  type        = map(string)
  default     = { "istio" : "ingressgateway" }
  description = "Ingress labels to use on the Gateway selector."
}

variable "hostname" {
  type        = string
  description = "Hostname of the ingress."
}

variable "ingress_restrictions" {
  type = object({
    allow_rules = list(object({
      type        = string,
      cidr_blocks = list(string),
      hostnames   = list(string),
    })),
    public_hostnames = list(string),
  })

  default = { allow_rules = [], public_hostnames = [] }

  description = "Ingress restrictions to allow only certain CIDR blocks to call specific hostnames."

  validation {
    condition = anytrue([
      length(var.ingress_restrictions.allow_rules) == 0,
      length(setsubtract(var.ingress_restrictions.allow_rules[*].type, ["ipBlocks", "remoteIpBlocks"])) == 0,
    ])
    error_message = "Parameter `type` on `allow_rules` should be `ipBlocks` for direct IP blocking or `remoteIpBlocks` for `X-Forwarded-For` header blocking."
  }
}

variable "enable_gzip" {
  type        = bool
  default     = false
  description = "Enable gzip compression for the ingress gateway."
}
