################################################################################
# Helm Config
################################################################################

variable "namespace" {
  type        = string
  description = "The namespace to install the components in."
}

variable "create_namespace" {
  type = bool

  default     = false
  description = "Create the namespace if it does not yet exist."
}

################################################################################
# VPA Config
################################################################################

variable "prometheus_url" {
  type = string

  default     = ""
  description = "The URL of the Prometheus instance to use (e.g. `http://prometheus.istio-system:9090`). VPA does not require the use of prometheus, but it is supported. The use of prometheus may provide more accurate results."
}

################################################################################
# Goldilocks Config
################################################################################

variable "chart_version" {
  type = string

  description = "The version of goldilocks to install."
}

variable "dashboard_requests" {
  type = object({ cpu = string, memory = string })

  default     = { cpu = "50m", memory = "64Mi" }
  description = "The requests for the goldilocks dashboard deployment."
}

variable "controller_requests" {
  type = object({ cpu = string, memory = string })

  default     = { cpu = "50m", memory = "64Mi" }
  description = "The requests for the goldilocks controller deployment."
}

variable "dashboard_limits" {
  type = object({ cpu = string, memory = string })

  default     = { cpu = "50m", memory = "64Mi" }
  description = "The limits for the goldilocks dashboard deployment."
}

variable "controller_limits" {
  type = object({ cpu = string, memory = string })

  default     = { cpu = "50m", memory = "64Mi" }
  description = "The limits for the goldilocks controller deployment."
}

################################################################################
# Ingress Config
################################################################################

variable "ingress_class" {
  type = string

  default     = ""
  description = "Ingress class to use."
}

variable "ingress_host" {
  type = string

  default     = ""
  description = "Ingress host to use."
}

################################################################################
# ArgoCD Config
################################################################################

variable "manage_via_argocd" {
  description = "Determines if the release should be managed via ArgoCD."
  type        = bool
  default     = false
}

variable "argocd_app_config" {
  description = "ArgoCD Application config. See k8s/argocd/resources/application"
  type        = any
  default     = {}
}
