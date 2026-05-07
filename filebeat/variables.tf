variable "namespace" {
  type = string

  default     = "filebeat"
  description = "The namespace to install the components in."
}

variable "create_namespace" {
  type = bool

  default     = true
  description = "Create the namespace if it does not yet exist."
}

variable "chart_version" {
  type = string

  description = "The version of filebeat helm to install."
}

variable "template_file" {
  type = string

  default     = ""
  description = "The template file to use for filebeat. If no template file is specified it will use the default one."
}

variable "template_values" {
  type = map(string)

  default     = {}
  description = "The values to use for resolve the template."
}

variable "helm_config" {
  type = any

  default     = {}
  description = "Helm provider config for filebeat"
}

variable "timeout" {
  type = number

  default     = 600
  description = "Time in seconds to wait for release installation."
}

variable "drop_fields" {
  type = list(string)

  default     = []
  description = "List of fields to drop from processing."
}

variable "drop_services" {
  type = list(string)

  default     = []
  description = "Drop events coming from these specific services (Kubernetes app label)."
}
