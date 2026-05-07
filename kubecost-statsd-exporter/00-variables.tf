variable "eks_cluster" {
  description = "Name of the EKS cluster."
  type        = string
}

variable "app_image_tag" {
  description = "Image tag for kafdrop"
  type        = string
}

variable "namespace" {
  description = "Namespace to deploy to."
  type        = string
}

variable "backend_port" {
  description = "App backend port for checks"
  type        = string
  default     = "8888"
}

variable "environment" {
  description = "Environment to deploy to."
  type        = string
}

variable "label" {
  description = "select the label to which group costs by (app or team)"
  type        = string
}

variable "kubecost_url" {
  description = "kubecost analyzer endpoint internal url"
  type        = string
  default     = "kubecost-cost-analyzer.kubecost:9090"
}

variable "statsd_host" {
  description = "StatsD sidecar host"
  type        = string
  default     = "localhost"
}

variable "statsd_port" {
  description = "StatsD sidecar port"
  type        = string
  default     = "9125"
}

variable "tags" {
  description = "Tags to be applied to resources."
  type        = map(string)

  default = {
    service = "kubecost-statsd-exporter",
    impact  = "low",
    team    = "product-infrastructure-team"
  }

  validation {
    condition = alltrue([
      contains(keys(var.tags), "team"),
      contains(keys(var.tags), "service"),
      contains(keys(var.tags), "impact"),
    ])
    error_message = "Required tags are missing! Please provide tags 'team', 'service' and 'impact'."
  }
}

variable "aws_region" {
  type        = string
  default     = ""
  description = "AWS region name to use on the name of the IAM role"
}
