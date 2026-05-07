################################################################################
# Helm Config
################################################################################

variable "namespace" {
  type = string

  default     = "kubecost"
  description = "The namespace to install the components in."
}

variable "create_namespace" {
  type = bool

  default     = true
  description = "Create the namespace if it does not yet exist."
}

variable "chart_version" {
  type = string

  description = "The version of Kubecost chart to install."
}

variable "helm_config" {
  type = any

  default     = {}
  description = "Helm provider config for Kubecost"
}

variable "timeout" {
  type = number

  default     = 600
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
# KubeCost template vars
################################################################################

variable "prometheus_enabled" {
  type = bool

  default     = false
  description = "Enables prometheus Agent."
}

variable "frontend_memory" {
  type = string

  default     = "256Mi"
  description = "Memory requests/limits for the frontend container (Kubernetes format)."
}

variable "model_memory" {
  type = string

  default     = "256Mi"
  description = "Memory requests/limits for the model container (Kubernetes format)."
}

################################################################################
# Custom template (this will ignore all the config)
################################################################################

variable "template_file" {
  type = string

  default     = ""
  description = "The template file to use for kubecost. If no template file is specified it will use the default one."
}
