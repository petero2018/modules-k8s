################################################################################
# AWS Secret Store Provider Class
################################################################################

variable "name" {
  description = "Name of the Provider Class"
  type        = string
}

variable "objects" {
  description = "Declaration of the secrets to be mounted."
  type = list(object({
    name          = string
    paths         = optional(map(string))
    type          = string
    alias         = optional(string)
    version       = optional(string)
    version_label = optional(string)
  }))

  validation {
    condition = alltrue([
      for object in var.objects : contains(["secretsmanager", "ssmparameter"], object.type)
    ])
    error_message = "Object type should be: secretsmanager or ssmparameter."
  }
}

variable "region" {
  description = "The AWS Region of the parameter."
  type        = string
  default     = null
}

variable "path_translation" {
  description = "A single substitution character to use if the file name (either objectName or objectAlias) contains the path separator character, such as slash (/) on Linux."
  type        = string
  default     = null
}

variable "generate_iam_policy" {
  description = "If true generates a IAM policy to be used by the IRSA."
  type        = bool
  default     = false
}
