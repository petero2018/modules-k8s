################################################################################
# Helm Config
################################################################################

variable "name" {
  description = "An arbitrary name of the software package installation (kinda \"chart instance\")."
  type        = string
}

variable "description" {
  description = "Helm release description."
  type        = string
  default     = ""
}

variable "namespace" {
  description = "Kubernetes namespace to install this chart release into."
  type        = string
}

variable "create_namespace" {
  description = "Create the namespace if it does not yet exist."
  type        = bool
  default     = false
}

variable "repository" {
  description = "Repository URL where to locate the requested chart."
  type        = string
  default     = "https://kubernetes-charts.storage.googleapis.com"
}

variable "repo_path" {
  description = "Path in the repo. Only used for git repos."
  type        = string
  default     = null
}
variable "chart" {
  description = "Helm chart name - a [well known] name of the software package itself."
  type        = string
  default     = null
}

variable "chart_version" {
  description = "Exact Helm chart version to install."
  type        = string
  default     = "HEAD"
}

variable "reset_values" {
  description = "When upgrading, reset the values to the ones built into the chart."
  type        = bool
  default     = false
}

variable "force_update" {
  description = "Force resource update through delete/recreate if needed."
  type        = bool
  default     = false
}

variable "timeout" {
  description = "Time in seconds to wait for release installation."
  type        = number
  default     = 600
}

variable "wait" {
  description = "Will wait until all resources are in a ready state before marking the release as successful."
  type        = bool
  default     = true
}

variable "additional_helm_config" {
  type        = any
  description = <<EOT
Release helm chart config, provide repository and version at the minimum.
See https://registry.terraform.io/providers/hashicorp/helm/latest/docs.
EOT
  default     = {}
}

variable "kustomization_file" {
  type        = string
  description = "Path to a kustomization.yaml file that will be used to change helm-managed resources via postrender. It should be an overlay that, at a minimum, uses \"base.yaml\" as a resource."
  default     = null

  validation {
    condition     = var.kustomization_file == null ? true : can(regex("^kustomization\\.ya?ml$", basename(var.kustomization_file)))
    error_message = "File must be named \"kustomization.yaml\" (or .yml)."
  }

  validation {
    condition     = var.kustomization_file == null ? true : contains(yamldecode(file(var.kustomization_file))["resources"], "base.yaml")
    error_message = "Provided kustomization_file does not inherit from 'base.yaml' resource."
  }
}

################################################################################
# Helm Values
################################################################################

variable "values" {
  description = "List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options."
  type        = list(string)
  default     = []
}

variable "set_values" {
  description = "Value blocks to be merged with the values YAML."
  type        = map(string)
  default     = {}
}

variable "set_string_values" {
  description = "Value blocks to be merged with the values YAML, explicitly as strings with no magic type conversion."
  type        = map(string)
  default     = {}
}

variable "set_sensitive_values" {
  description = "Value blocks to be merged with the values YAML without being exposed in plan diff."
  type        = map(string)
  default     = {}
}

variable "set_sensitive_values_from_ssm" {
  description = "Secret \"name:ssm_path\" blocks to be fetched from SSM and merged with the values YAML."
  type        = map(string)
  default     = {}
}

variable "value_files" {
  description = "Helm values files for overriding values in the helm chart."
  type        = list(string)
  default     = []
}

################################################################################
# IRSA
################################################################################

variable "create_irsa" {
  description = "Whether to create IRSA or not."
  type        = bool
  default     = true
}

variable "eks_cluster" {
  description = "EKS cluster to get OIDC issuer/authorize from."
  type        = string
}

variable "service_account" {
  description = "Kubernetes Service Account Name"
  type        = string
  default     = null
}

variable "service_account_helm_config" {
  type = object({
    create_path      = string
    annotations_path = string
    name_path        = string
  })
  default = {
    create_path      = "serviceAccount.create"
    annotations_path = "serviceAccount.annotations"
    name_path        = "serviceAccount.name"
  }
  description = "Helm Paths to configure Service Account"
}

variable "iam_role_name" {
  description = "Name of the IAM role to create."
  type        = string
  default     = ""
}

variable "iam_role_path" {
  description = "IAM role path for IRSA roles."
  type        = string
  default     = null
}

variable "iam_permissions_boundary" {
  description = "IAM permissions boundary for IRSA roles"
  type        = string
  default     = ""
}

variable "iam_policy_arns" {
  description = "IAM policy ARNs for IRSA IAM role."
  type        = list(string)
  default     = []
}

variable "iam_policy_documents" {
  description = "Documents to create inline IAM policies for IRSA IAM role."
  type        = map(string)

  default = {}
}


################################################################################
# Node Selector
################################################################################

variable "node_selector" {
  type = map(string)

  default     = {}
  description = "Node Selector for the deployment"
}

variable "tolerations" {
  type = list(object({
    key      = string
    operator = string
    value    = optional(string)
    effect   = string
  }))

  default     = []
  description = "Tolerations for the deployment"
}

################################################################################
# ArgoCD
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
# AWS Tags
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
