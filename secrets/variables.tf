variable "namespace" {
  description = "Kubernetes namespace to deploy secrets into."
  type        = string
}

variable "secrets" {
  description = "A map of secret objects (name => data) to provision."
  type        = map(map(string))
}

variable "labels" {
  description = "Labels to identify resource ownership."
  type        = map(string)
  validation {
    condition = alltrue([
      contains(keys(var.labels), "team"),
      contains(keys(var.labels), "service"),
      contains(keys(var.labels), "impact"),
    ])
    error_message = "\"labels\" must contain at least those tags: \"team\", \"impact\", \"service\"."
  }
}
