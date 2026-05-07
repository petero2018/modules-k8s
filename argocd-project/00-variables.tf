################################################################################
# ArgoCD Config
################################################################################

variable "namespace" {
  type = string

  default     = "argocd"
  description = "The namespace where ArgoCD is installed."
}

################################################################################
# ArgoCD Project Config
################################################################################

variable "name" {
  type = string

  description = "Project name."
}

variable "description" {
  type = string

  description = "Project description."
}

variable "source_repos" {
  type = list(string)

  description = "Allowed source repos to be used by this Project"
}

variable "destinations" {
  type = list(object({
    namespace = string
    server    = optional(string)
  }))

  description = "Destinations where to deploy apps in. Which namespaces usually."
}

################################################################################
# ArgoCD Project Resource Permissions
################################################################################

variable "cluster_resource_allow_list" {
  type = list(object({
    group = string
    kind  = string
  }))

  default = [
    # By default only allow create namespaces
    {
      group = ""
      kind  = "Namespace"
    }
  ]
  description = "List of cluster resources allowed to be created by this project."
}

variable "namespace_resource_allow_list" {
  type = list(object({
    group = string
    kind  = string
  }))

  default     = null
  description = "If defined deny all namespaced-scoped resources except the defined ones."
}

variable "namespace_resource_deny_list" {
  type = list(object({
    group = string
    kind  = string
  }))

  default     = null
  description = "If defined allows all namespaced-scoped resources except the defined ones."
}

################################################################################
# ArgoCD Project Permissions
################################################################################

variable "roles" {
  type = map(object({
    description = string
    policies = list(object({
      resource = optional(string)
      action   = string
      object   = optional(string)
    }))
    groups = list(string)
  }))

  default     = null
  description = "Project permissions to be applied to one or many groups"
}

################################################################################
# ArgoCD Project Config Advanced
################################################################################

variable "finalizers" {
  type = list(string)

  default = [
    # Finalizer that ensures that project is not deleted until it is not referenced by any application
    "resources-finalizer.argocd.argoproj.io"
  ]
  description = "ArgoCD Finalizers to be executed before delete the Project."
}
