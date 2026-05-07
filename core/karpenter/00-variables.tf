################################################################################
# EKS Cluster
################################################################################

variable "eks_cluster" {
  description = "Name of the EKS cluster to deploy into."
  type        = string
}

variable "eks_cluster_endpoint" {
  description = "EKS cluster endpoint."
  type        = string
}

variable "worker_role_name" {
  description = "EKS Cluster worker role name."
  type        = string
}

variable "iam_suffix" {
  description = "Will be appended to the end of IAM-related resources to help maintain uniqueness in multi-cluster/multi-region setups"
  type        = string
  default     = ""
}

variable "install_crds" {
  description = "CRDs appropriate for the current version will be managed using the separate Helm chart. See https://karpenter.sh/v0.33/troubleshooting/#helm-error-when-installing-the-karpenter-crd-chart if you encounter errors."
  type        = bool
  default     = true
}

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

  default     = 300
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
# Tags
################################################################################

variable "tags" {
  description = "Tags to be applied to AWS resources."
  type        = map(string)

  validation {
    condition = alltrue([
      contains(keys(var.tags), "team"),
      contains(keys(var.tags), "service"),
      contains(keys(var.tags), "impact"),
    ])
    error_message = "Required tags are missing! Please provide tags 'team', 'service' and 'impact'."
  }
}
