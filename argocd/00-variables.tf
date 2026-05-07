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

variable "helm_set_values" {
  type = map(string)

  default     = {}
  description = "Value blocks to be merged with the values YAML and passed to the helm module"
}

variable "helm_values" {
  type = list(string)

  default     = []
  description = "List of values in raw yaml to pass to the helm module."
}

variable "timeout" {
  type = number

  default     = 1200
  description = "Time in seconds to wait for release installation."
}

################################################################################
# ArgoCD Config
################################################################################

variable "admin_password" {
  type = string

  description = "admin password."
  sensitive   = true
}

variable "ui_domain" {
  type = string

  description = "Domain to use for ArgoCD."
}

variable "enable_ingress" {
  type = bool

  default     = false
  description = "Enables ArgoCD ingress."
}

variable "ingress_class" {
  type = string

  default     = ""
  description = "Ingress class to use."
}

variable "roles" {
  type = map(list(object({
    resource = string
    action   = string
    object   = string
  })))
  default = {
    dev = [
      { resource = "clusters", action = "get", object = "*" },
      { resource = "repositories", action = "get", object = "*" }
      # Project / Application access should be set up on project configuration
    ]
  }
  description = "Permissions roles to apply"
}

variable "data_permissions" {
  type = string

  default     = <<EOH
      p, role:data, applications, get, */*, allow
      p, role:data, certificates, get, *, allow
      p, role:data, clusters, get, *, allow
      p, role:data, repositories, get, *, allow
      p, role:data, projects, get, *, allow
      p, role:data, accounts, get, *, allow
      p, role:data, gpgkeys, get, *, allow
      p, role:data, applications, update, */*, allow
      p, role:data, applications, sync, */*, allow
      p, role:data, applications, override, */*, allow
      p, role:data, applications, action/*, */*, allow
      p, role:data, applications, delete, */*, allow
      g, argocd-data, role:data
  EOH
  description = "Permissions for DATA Teams"

}

################################################################################
# OKTA Integration
################################################################################

variable "okta_enable" {
  type = bool

  default     = false
  description = "Flag to enable or disable OKTA integration."
}

variable "okta_sso_domain" {
  type = string

  default     = ""
  description = "OKTA SSO domain."
  sensitive   = true
}

variable "okta_ca_base64" {
  type = string

  default     = ""
  description = "OKTA CA in base64."
  sensitive   = true
}

variable "okta_admin" {
  type = string

  default     = "admins"
  description = "OKTA Group to assign admin permissions on ArgoCD."
}

variable "okta_groups" {
  type = map(string)

  default = {
    Developers = "dev"
  }
  description = "OKTA Group to assign ArgoCD roles."
}
