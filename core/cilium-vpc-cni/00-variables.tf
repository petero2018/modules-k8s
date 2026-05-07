################################################################################
# EKS Cluster
################################################################################

variable "eks_cluster" {
  description = "Name of the EKS cluster to deploy into."
  type        = string
}

################################################################################
# VPC CNI
################################################################################

variable "vpc_cni_version" {
  description = "\"VPC CNI\" EKS addon version."
  type        = string
}

################################################################################
# Cilium
################################################################################

variable "cilium_version" {
  description = "Cilium helm release version."
  type        = string
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
# Labels / Annotations / Tags
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
