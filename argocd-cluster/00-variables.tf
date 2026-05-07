################################################################################
# ArgoCD Config
################################################################################

variable "namespace" {
  type = string

  default     = "argocd"
  description = "The namespace where ArgoCD is installed."
}

################################################################################
# ArgoCD Cluster Config
################################################################################

variable "auth_iam_role_arn" {
  type = string

  description = "The ARN of the role used to authenticate against the remote cluster."
}

variable "cluster_name" {
  type = string

  description = "Remote cluster name."
}

variable "managed_namespaces" {
  type = list(string)

  default     = []
  description = "A list of namespaces that ArgoCD is permitted to manage."
}

variable "manage_cluster_resources" {
  type = bool

  default     = false
  description = "Whether Argo CD can manage cluster-level resources on this cluster. This setting is used only if the list of managed namespaces is not empty."
}

variable "environment" {
  type = string

  description = "The environment (`dev`, `prod` or `tools`) of the remote cluster. Will be added as label to the cluster secret."

  validation {
    condition     = contains(["dev", "prod", "tools"], var.environment)
    error_message = "Environment must be one of [dev, prod, tools]."
  }
}

variable "labels" {
  type = map(string)

  default     = {}
  description = "A map of extra labels that will be applied to the cluster secret."
}

################################################################################
# Misc.
################################################################################

variable "create_suffixed_role" {
  type        = bool
  default     = false
  description = "If true, the remote role will be suffixed with the destination cluster name. This can be used to create separate roles when multiple clusters exist within a single account."
}

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
