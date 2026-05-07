variable "namespace" {
  type = string

  default     = "kube-system"
  description = "The namespace to install the components in."
}

variable "chart_version" {
  type = string

  description = "The version of external dns chart to install."
}

variable "allow_external_dns_zone_ids" {
  type = list(string)

  default     = []
  description = "List of Route53 hosted zone IDs we allow ExternalDNS to access."
}

variable "eks_cluster" {
  type = string

  description = "Name of the EKS cluster to deploy into."
}

variable "aws_region" {
  description = "Region name where the cluster is running. This will be used for the name of the IAM role to be used by the controller."
  type        = string
}

variable "txt_owner_id" {
  type = string

  default     = ""
  description = "DNS record \"owner ID\" stored in accompanying TXT record (will be set to cluster name if empty)"
}

variable "timeout" {
  type = number

  default     = 600
  description = "Time in seconds to wait for release installation."
}

variable "interval" {
  type = string

  default     = "1m"
  description = "Poll interval to update the records."
}

variable "watch_events" {
  type = bool

  default     = false
  description = "Update records on events instead of just when polling."
}

variable "tags" {
  type = map(string)
  validation {
    condition = alltrue([
      contains(keys(var.tags), "team"),
      contains(keys(var.tags), "service"),
      contains(keys(var.tags), "impact"),
    ])
    error_message = "Required tags are missing! Please provide tags 'team', 'service' and 'impact'."
  }

  description = "Tags to be applied to AWS resources."
}

variable "node_selector" {
  type = map(any)

  description = "Node labels for pod assignment."
  default     = {}
}
