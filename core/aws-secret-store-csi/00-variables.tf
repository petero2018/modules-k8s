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

  description = "The version of Secret Store CSI to install."
}

variable "repository" {
  type = string

  default     = "https://aws.github.io/eks-charts"
  description = "The Helm chart repository URL for the AWS Secrets Store CSI Driver."
}

variable "chart_name" {
  type = string

  default     = "csi-secrets-store-provider-aws"
  description = "The name of the Helm chart for the AWS Secrets Store CSI Driver."
}

variable "helm_config" {
  type = any

  default     = {}
  description = "Helm provider config for Secret Store CSI"
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
# Secret Store CSI Config
################################################################################

variable "sync_secret" {
  type = bool

  default     = true
  description = "It creates a Kubernetes Secret to mirror the mounted content."
}

variable "secret_rotation" {
  type = bool

  default     = true
  description = "When the secret/key is updated in external secrets store after the initial pod deployment, the updated secret will be periodically updated."
}

variable "secret_rotation_interval" {
  type = string

  default     = "2m"
  description = "Rotation poll interval"
}
