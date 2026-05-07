variable "name" {
  description = "The name of security group policy."
  type        = string
}

variable "namespace" {
  description = "The namespace of security group policy."
  type        = string
}

variable "selector" {
  description = "The selector for security group policy."
  type        = string
  validation {
    condition     = contains(["podSelector", "serviceAccountSelector"], var.selector)
    error_message = "Illegal selector for the security group policy."
  }
}

variable "match_labels" {
  description = "The match labels for the security group policy."
  type        = map(string)
}

variable "match_expressions" {
  description = "The match expressions for the security group policy."
  type = list(object({
    key      = string,
    operator = string,
    values   = list(string),
  }))
}

variable "security_group_ids" {
  description = "The security group ids for the security group policy."
  type        = list(string)

  validation {
    condition     = length(var.security_group_ids) >= 1 && length(var.security_group_ids) <= 5
    error_message = "You must specify 1-5 security group IDs ."
  }
}
