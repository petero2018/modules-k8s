variable "eks_cluster" {
  description = "Name of the EKS cluster to deploy into."
  type        = string
}

variable "aws_region" {
  description = "AWS Region name."
  type        = string
}

variable "namespace" {
  type = string

  default     = "velero"
  description = "The namespace to install the components in."
}

variable "create_namespace" {
  type = bool

  default     = true
  description = "Create the namespace if it does not yet exist."
}

variable "chart_version" {
  type        = string
  description = "The version of velero helm to install."
}

variable "features" {
  type = list(string)

  default     = ["EnableCSI"]
  description = "A list of Velero features to enable. See https://velero.io/docs/main/customize-installation/ for more information."
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
  description = "Helm provider config for velero"
}

variable "timeout" {
  type = number

  default     = 600
  description = "Time in seconds to wait for release installation."
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

variable "deploy_arch" {
  type        = string
  description = "Node architecture to deploy to. Must be either \"amd64\" or \"arm64\""
  default     = "arm64"

  validation {
    condition     = contains(["amd64", "arm64"], var.deploy_arch)
    error_message = "Valid values for node architecture are: (amd64, arm64)"
  }
}
