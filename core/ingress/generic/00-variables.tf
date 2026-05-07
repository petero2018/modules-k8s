variable "ingress_name" {
  type = string

  description = "Name of the environment/namespace to serve with this ingress."
}

variable "namespace" {
  type = string

  default     = "istio-system"
  description = "Namespace to install kubernetes resources."
}

variable "eks_cluster" {
  type = string

  description = "Name of the EKS cluster to deploy into."

  validation {
    condition     = length(split("-", var.eks_cluster)) == 2
    error_message = "Cluster name should be passed in ENV-CLUSTER form."
  }
}

variable "ingress_type" {
  type        = string
  default     = "powise-alb"
  description = "Type of the ingress resource to use (\"powise-alb\" or \"powise-nlb\"). Default is \"powise-alb\"."

  validation {
    condition     = contains(["powise-alb", "powise-nlb"], var.ingress_type)
    error_message = "Unsupported ingress type!"
  }
}

variable "ingress_purpose" {
  type        = string
  description = "Purpose of the ingress."

  validation {
    condition     = contains(["public", "restricted", "internal", "wildcard"], var.ingress_purpose)
    error_message = "Unsupported ingress purpose!"
  }
}

variable "hostname" {
  type        = string
  description = "Hostname of the ingress."
}

variable "dns_zone" {
  type        = string
  default     = null
  description = "DNS zone used for certificate validation (if certificate is created)."
}

variable "acm_certificate_arn" {
  type        = string
  default     = null
  description = "ACM certificate ARN to use on the load balancer (if not creatng certificate)."
}

variable "cidr_blocks" {
  type        = list(string)
  default     = null
  description = "CIDR blocks to open the load balancer to."
}

variable "backend_service_ports" {
  type = object({
    http  = number
    https = number
  })
  default = {
    http  = 80
    https = 443
  }
  description = "Ports configured on the backend service."
}

variable "backend_service_name" {
  type        = string
  default     = null
  description = "Name of the backend service to use."
}

variable "alb_config" {
  type = object({
    backend_protocol     = string
    healthcheck_protocol = string
    healthcheck_path     = string
  })
  default = {
    backend_protocol     = "HTTPS"
    healthcheck_protocol = "HTTPS"
    healthcheck_path     = "/health"
  }
  description = "ALB configuration. Makes sense to configure only for \"powise-alb\" ingress type."
}

variable "environment_type" {
  type = string

  default     = "normal"
  description = "Is this a part of normal or ephemeral environment?"

  validation {
    condition     = contains(["normal", "ephemeral"], var.environment_type)
    error_message = "Unsupported environment type!"
  }
}

variable "open_http" {
  type    = bool
  default = true # Backwards compatibility

  description = "Whether to open the HTTP port (80)."
}

variable "public_subnet_tags" {
  type        = map(string)
  description = "Discover public subnets by these tags (for ingress/ALB)."
}

variable "private_subnet_tags" {
  type        = map(string)
  description = "Discover private subnets by these tags (for ingress/ALB)."
}
