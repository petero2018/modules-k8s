variable "worker_role_names" {
  type = list(string)

  description = "IAM role names for worker node groups (used in aws-auth config map)."
}

variable "roles" {
  description = "AWS roles to add to the aws-auth configmap."
  type = list(object({
    role     = string
    username = string
    groups   = list(string)
  }))
  default = [
    {
      role     = "DevRole"
      username = "dev"
      groups   = ["developers"]
    }
  ]
}

variable "groups" {
  description = "Kubernetes groups to authorize"
  type = list(object({
    name      = string
    global    = optional(list(string))
    namespace = optional(map(list(string)))
  }))
  default = [
    {
      name   = "developers"
      global = ["view"]
    }
  ]
}

variable "labels" {
  description = "Labels to be applied to resources."
  type        = map(string)
  default     = {}
}

variable "annotations" {
  description = "Annotations to be applied to resources."
  type        = map(string)
  default     = {}
}
