################################################################################
# Helm Config
################################################################################

variable "chart_version" {
  type        = string
  default     = "2.2.1"
  description = "Snyk monitor helm chart version to use (https://github.com/snyk/kubernetes-monitor/tree/staging/snyk-monitor)."
}

################################################################################
# Deployment
################################################################################

variable "eks_cluster" {
  type = string

  description = "Name of the EKS cluster to deploy into."
}

variable "environment" {
  type = string

  description = "Deploy environment (\"dev\", \"prod\" or \"tools\")."

  validation {
    condition     = contains(["dev", "prod", "tools"], var.environment)
    error_message = "Illegal environment name."
  }
}

variable "iam_suffix" {
  type        = string
  default     = null
  description = "Will be appended to the end of IAM-related resources to help maintain uniqueness in multi-cluster/multi-region setups"
}

################################################################################
# Namespace
################################################################################

variable "enable_istio" {
  type        = bool
  default     = false
  description = "Enable istio service mesh? configure_namespace must be true"
}

variable "dockercfg_json" {
  type        = string
  default     = ""
  description = "JSON dockercfg used by snyk-monitor to access to quay.io. configure_namespace must be true"
}

################################################################################
# Snyk Config
################################################################################

variable "integration_ids" {
  type = map(string)
  default = {
    prod  = "589ae8da-aea8-448c-bbda-b1335cf9a265"
    dev   = "e40d394e-3076-45fe-a9bf-e3546270573c"
    tools = "589ae8da-aea8-448c-bbda-b1335cf9a265"
  }
  description = "Integration ID for Snyk monitor, used to identify the integration in the Snyk UI."
}

variable "service_account_api_token" {
  type        = string
  description = "API Token which enables Snyk monitor to communicate with the Snyk API."
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
