################################################################################
# Helm Config
################################################################################

variable "namespace" {
  type = string

  default     = "kube-system"
  description = "The namespace to install the components in."
}

variable "create_namespace" {
  type = bool

  default     = false
  description = "Create the namespace if it does not yet exist."
}

variable "chart_version" {
  type = string

  description = "The version of argocd to install."
}

variable "helm_config" {
  type = any

  default     = {}
  description = "Helm provider config for argocd"
}

variable "timeout" {
  type = number

  default     = 1200
  description = "Time in seconds to wait for release installation."
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

################################################################################
# Prometheus Config
################################################################################

variable "retention" {
  type = string

  default     = "15d"
  description = "Prometheus data retention period."
}

variable "scrape_interval" {
  type = string

  default     = "15s"
  description = "How frequently to scrape targets."
}

variable "volume_size" {
  type = string

  default     = "50Gi"
  description = "Prometheus server data Persistent Volume size."
}
