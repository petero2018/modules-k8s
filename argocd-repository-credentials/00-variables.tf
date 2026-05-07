################################################################################
# ArgoCD Config
################################################################################

variable "name" {
  type = string

  description = "Name of the repository credentials"
}

variable "namespace" {
  type = string

  default     = "argocd"
  description = "The namespace where ArgoCD is installed."
}

################################################################################
# Repository Credentials
################################################################################

variable "url" {
  type = string

  description = "URL of the repository."
}

variable "type" {
  type = string

  default     = "git"
  description = "Repository type. Must be: git or helm"

  validation {
    condition     = contains(["git", "helm"], var.type)
    error_message = "Repository Credentials type must be git or helm."
  }
}

variable "username" {
  type = string

  default     = null
  description = "If username/password is not specified, must specify ssh_private_key."
}

variable "password" {
  type = string

  default     = null
  description = "If username/password is not specified, must specify ssh_private_key."

  sensitive = true
}

variable "ssh_private_key" {
  type = string

  default     = null
  description = "If not specified, must specify username/password."

  sensitive = true
}

################################################################################
# Labels / Annotations
################################################################################

variable "labels" {
  description = "Labels to be applied to K8S resources."
  type        = map(string)
  default     = {}
}

variable "annotations" {
  description = "Annotations to be applied to K8S resources."
  type        = map(string)
  default     = {}
}
