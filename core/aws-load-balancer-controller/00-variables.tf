################################################################################
# EKS Cluster
################################################################################

variable "eks_cluster" {
  description = "Name of the EKS cluster to deploy into."
  type        = string
}

variable "aws_region" {
  description = "Region name where the cluster is running. This will be used for the name of the IAM role to be used by the controller."
  type        = string
  default     = ""
}

variable "iam_role_path" {
  description = "IAM role path for IRSA roles."
  type        = string
  default     = null
}

################################################################################
# Release
################################################################################

variable "namespace" {
  description = "The namespace to install the components in."
  type        = string
  default     = "kube-system"
}

variable "chart_version" {
  description = "The version of aws load balancer controller chart to install."
  type        = string
}

variable "helm_config" {
  description = "Helm provider config for aws load balancer controller"
  type        = any
  default     = {}
}

variable "timeout" {
  description = "Time in seconds to wait for release installation."
  type        = number
  default     = 1200
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
