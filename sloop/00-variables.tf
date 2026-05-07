################################################################################
# Helm Config
################################################################################

variable "namespace" {
  type = string

  default     = "sloop"
  description = "The namespace to install the components in."
}

variable "create_namespace" {
  type = bool

  default     = true
  description = "Create the namespace if it does not yet exist."
}

variable "git_version" {
  type = string

  description = "The version of github to install. Can be a branch / tag."
}

variable "timeout" {
  type = number

  default     = 1200
  description = "Time in seconds to wait for release installation."
}

################################################################################
# ArgoCD Config
################################################################################

variable "argocd_app_config" {
  description = "ArgoCD Application config. See k8s/argocd/resources/application"
  type        = any
  default     = {}
}

################################################################################
# Sloop Ingress
################################################################################

variable "enable_ingress" {
  type = bool

  default     = false
  description = "Enables Sloop ingress."
}

variable "ingress_class" {
  type = string

  default     = ""
  description = "Ingress class to use."
}

variable "ingress_domain" {
  type = string

  default     = ""
  description = "Ingress domain to use."
}

################################################################################
# Sloop CRD
################################################################################

variable "watch_crd" {
  type = bool

  default     = false
  description = "Flag to watch CRD."
}

variable "crd_api_groups" {
  type = list(string)

  default     = []
  description = "List of CRD API Groups to monitor"
}

################################################################################
# Sloop Storage
################################################################################

variable "pv_class" {
  type = string

  default     = null
  description = "Storage class to use. undefined will fall back to the cluster default."
}

variable "pv_size" {
  type = string

  default     = "10Gi"
  description = "Storage size."
}

variable "pv_size_max" {
  type = string

  default     = "12Gi"
  description = "Max Storage size."
}
