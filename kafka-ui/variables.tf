variable "namespace" {
  type = string

  description = "A Kubernetes namespace to deploy into"
}

variable "iam_role_arn" {
  type = string

  description = "ARN of the IAM role to assume inside the pod"
}

variable "chart_version" {
  description = "Version of the Kafka UI Helm chart"
  type        = string

  validation {
    condition     = can(regex("^[0-9]+\\.[0-9]+\\.[0-9]+", var.chart_version))
    error_message = "Chart version must be in semantic versioning format (e.g., 1.2.3)."
  }
}

variable "hostname" {
  description = "Hostname for accessing the Kafka UI"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9.-]+$", var.hostname))
    error_message = "Hostname must be a valid DNS name."
  }
}

variable "istio_gateway" {
  description = "Name of the upstream Istio gateway in form of <namespace>/<gateway>"
  type        = string
}

variable "cluster_name" {
  description = "Name of the Kafka cluster"
  type        = string
}

variable "bootstrap_servers" {
  description = "Kafka broker connection strings"
  type        = string
}

variable "scale" {
  description = "Scaling configuration for Kafka UI"
  type = object({
    min_replicas = number
    max_replicas = number
  })

  default = { min_replicas = 1, max_replicas = 10 }

  validation {
    condition     = var.scale.min_replicas <= var.scale.max_replicas
    error_message = "Minimum replicas must be less than or equal to maximum replicas."
  }
}

variable "resources" {
  description = "Resource configuration for Kafka UI pods"
  type = object({
    cpu_requests    = string
    memory_requests = string
    memory_limits   = string
  })

  default = { cpu_requests = "500m", memory_requests = "500Mi", memory_limits = "1Gi" }
}
