variable "eks_cluster" {
  description = "Name of the EKS cluster to deploy into."
  type        = string
}

variable "aws_region" {
  description = "Name of the current AWS region."
  type        = string
}

variable "route53_zones" {
  type = list(object({
    id     = string
    domain = string
  }))
  description = "List of Route53 zones to act upon."
}

variable "acme_email" {
  type        = string
  default     = "ops+cert-manager@powise.com"
  description = "Email to use for the ACME challenge."
}

variable "enable_cainjector" {
  type        = bool
  default     = true
  description = "Whether to enable the CA Injector component."
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
