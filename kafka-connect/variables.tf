variable "app_version" {
  type = string

  description = "Application version AKA container image tag"

  validation {
    condition     = var.app_version != "latest"
    error_message = "Using \"latest\" is a bad and dangerous practice"
  }
}

variable "environment" {
  type = string

  description = "Application deploy environment"

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "Must be either \"dev\" or \"prod\""
  }
}

variable "aws_region" {
  type = string

  description = "AWS region to deploy into"
}

variable "namespace" {
  type = string

  description = "A Kubernetes namespace to deploy into"
}

variable "iam_role_arn" {
  type = string

  description = "ARN of the IAM role to assume inside the pod"
}

variable "chart_version" {
  type = string

  description = "Version of \"tf-http-server\" chart to install"
}

variable "image_repository" {
  type = string

  description = "Container image repository to pull images from"

  default = "567716553783.dkr.ecr.us-east-1.amazonaws.com/powise-kafka-connect"
}

variable "app_config" {
  type = object({
    bootstrap_servers        = string
    group_id                 = optional(string, "kafka-connect")
    replication_factor       = optional(number, 3)
    config_storage_topic     = optional(string, "kafka-connect-configs")
    offset_storage_topic     = optional(string, "kafka-connect-offsets")
    offset_flush_interval_ms = optional(number, 10000)
    status_storage_topic     = optional(string, "kafka-connect-status")
    api_port                 = optional(number, 8083)
  })

  description = "Application configuration set as environment variables"
}

variable "resources" {
  type = object({
    cpu_requests    = string
    memory_requests = string
    memory_limits   = string
  })

  default = {
    cpu_requests    = "1"
    memory_requests = "4Gi"
    memory_limits   = "6Gi"
  }

  description = "Kubernetes resource constraints"
}

variable "scale" {
  type = object({
    min_replicas = number
    max_replicas = number
  })

  description = "Kubernetes HPA config"

  validation {
    condition     = var.scale.max_replicas >= var.scale.min_replicas
    error_message = "Must set \"max_replicas\" to equal or higher value than \"min_replicas\" has"
  }

  default = { min_replicas = 3, max_replicas = 10 }
}

variable "hostname" {
  type = string

  description = "Access FQDN"
}

variable "istio_gateway" {
  type = string

  description = "Name of the upstream Istio gateway in form of <namespace>/<gateway>"
}

variable "log_level" {
  description = "Log level for Kafka Connect"
  type        = string
  default     = "WARN"

  validation {
    condition = contains([
      "TRACE",
      "DEBUG",
      "INFO",
      "WARN",
      "ERROR",
      "FATAL",
      "OFF"
    ], var.log_level)
    error_message = "The log_level must be one of: TRACE, DEBUG, INFO, WARN, ERROR, FATAL, or OFF."
  }
}
