################################################################################
# ArgoCD Config
################################################################################

variable "namespace" {
  type = string

  default     = "argocd"
  description = "The namespace where ArgoCD is installed."
}

variable "project" {
  type = string

  description = "ArgoCD Project to add the "
}

################################################################################
# ArgoCD Application
################################################################################

variable "name" {
  type = string

  description = "Name of the ArgoCD Application"
}

################################################################################
# ArgoCD Application Source
################################################################################

variable "repo_url" {
  type = string

  description = "Repository URL. Can be a Helm chart repo or a git repo."
}

# Git Repo Config

variable "target_revision" {
  type = string

  default     = null
  description = "Target revision. For helm this refers to the chart version."
}

variable "repo_path" {
  type = string

  default     = null
  description = "Path in the repo. Only used for git repos."
}

# Helm Config

variable "chart" {
  type = string

  default     = null
  description = "Helm chart to install. Only used for helm chart repos."
}

variable "release_name" {
  type = string

  default     = null
  description = "Helm Release name. defaults to application name."
}

# Helm Values

variable "set_values" {
  type = map(string)

  default     = {}
  description = "Value blocks to be merged with the values YAML."
}

variable "set_string_values" {
  type = map(string)

  default     = {}
  description = "Value blocks to be merged with the values YAML, explicitly as strings with no magic type conversion."
}

variable "set_sensitive_values" {
  type = map(string)

  default     = {}
  description = "Value blocks to be merged with the values YAML without being exposed in plan diff."

  sensitive = true
}

variable "file_values" {
  type = list(object({
    name = string
    path = string
  }))

  default     = []
  description = "Use the contents of files as parameters (uses Helm's --set-file)"
}

variable "value_files" {
  type = list(string)

  default     = []
  description = "Helm values files for overriding values in the helm chart."
}

variable "values" {
  type = list(string)

  default     = []
  description = "List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options."
}

################################################################################
# ArgoCD Application Destination
################################################################################

variable "destination_namespace" {
  type = string

  description = "Destination namespace to create the resources in."
}

################################################################################
# ArgoCD Application Sync Automation
################################################################################

variable "sync_automated" {
  type = bool

  default     = true
  description = "Automatically Sync the app when it detects differences between the desired manifests in Git, and the live state in the cluster."
}

variable "sync_automated_prune" {
  type = bool

  default = true
  # https://argo-cd.readthedocs.io/en/stable/user-guide/sync-options/#no-prune-resources
  description = "Specifies if resources should be pruned during auto-syncing. Only if automated is true."
}

variable "sync_automated_self_heal" {
  type = bool

  default = true
  # https://argo-cd.readthedocs.io/en/stable/user-guide/auto_sync/#automatic-self-healing
  description = "Specifies if partial app sync should be executed when resources are changed only in target Kubernetes cluster and no git change detected. Only if automated is true."
}

variable "sync_automated_allow_empty" {
  type = bool

  default = false
  # https://argo-cd.readthedocs.io/en/stable/user-guide/auto_sync/#automatic-pruning-with-allow-empty-v18
  description = "Allows deleting all application resources during automatic syncing. Only if automated is true."
}

################################################################################
# ArgoCD Application Sync Retry
################################################################################

variable "sync_retry" {
  type = number

  default     = 5
  description = "Number of failed sync attempt retries; unlimited number of attempts if less than 0."
}

variable "sync_backoff_duration" {
  type = string

  default     = "5s"
  description = "The amount to back off. Default unit is seconds, but could also be a duration (e.g. \"2m\", \"1h\")."
}

variable "sync_backoff_factor" {
  type = number

  default     = 2
  description = "A factor to multiply the base duration after each failed retry."
}

variable "sync_backoff_max_duration" {
  type = string

  default     = "3m"
  description = "The maximum amount of time allowed for the backoff strategy."
}

################################################################################
# ArgoCD Application Sync
################################################################################

variable "sync_validate" {
  type = bool

  default = true
  # https://argo-cd.readthedocs.io/en/stable/user-guide/sync-options/#disable-kubectl-validation
  description = "Enables resource validation. (equivalent to 'kubectl apply --validate=')"
}

variable "sync_create_namespace" {
  type = bool

  default     = false
  description = "Namespace Auto-Creation ensures that namespace specified as the application destination exists in the destination cluster."
}

variable "sync_prune_propagation_policy" {
  type = string

  default = "foreground"
  # https://argo-cd.readthedocs.io/en/stable/user-guide/sync-options/#resources-prune-deletion-propagation-policy
  # https://kubernetes.io/docs/concepts/architecture/garbage-collection/#controlling-how-the-garbage-collector-deletes-dependents
  description = "Prune propagation policy."

  validation {
    condition     = contains(["background", "foreground", "orphan"], var.sync_prune_propagation_policy)
    error_message = "Prune Propagation Policy must be background, foreground or orphan."
  }
}

variable "sync_prune_last" {
  type = bool

  default = true
  # https://argo-cd.readthedocs.io/en/stable/user-guide/sync-options/#prune-last
  description = "Allow the ability for resource pruning to happen as a final, implicit wave of a sync operation."
}

################################################################################
# Labels
################################################################################

variable "labels" {
  description = "Labels to be applied to Application."
  type        = map(string)
  default     = {}
}
