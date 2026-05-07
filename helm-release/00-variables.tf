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
}

variable "chart_version" {
  description = "Exact Helm chart version to install."
  type        = string
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

variable "enable_oci" {
  description = "whether helm repository is OCI."
  type        = bool
  default     = false
}

################################################################################
# Helm Values
################################################################################


variable "deploy_arch" {
  type        = string
  description = "Node architecture to deploy to. Must be either \"amd64\" or \"arm64\""

  validation {
    condition     = var.deploy_arch == null ? true : contains(["amd64", "arm64"], var.deploy_arch)
    error_message = "Valid values for node architecture are: (amd64, arm64)"
  }

  default = null
}


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
