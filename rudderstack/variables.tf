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

variable "namespace" {
  type = string

  description = "A Kubernetes namespace to deploy into"
}

variable "chart_version" {
  type = string

  description = "Version of \"tf-http-server\" chart to install"
}

variable "image_repository" {
  type = string

  description = "Container image repository to pull images from"

  default = "567716553783.dkr.ecr.us-east-1.amazonaws.com/data-rudderstackdep"
}

variable "config" {
  type = object({
    consumer_group_id         = string
    destination_topic         = string
    internal_queue_topic      = string
    kafka_brokers             = list(string)
    kafka_brokers_tls         = bool
    kafka_consumer_group_name = string
    port                      = number
  })

  description = "DEP application configuration set as environment variables"
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
}

variable "resources" {
  type = object({
    cpu_requests    = string
    memory_requests = string
    memory_limits   = string
  })

  description = "Kubernetes resource constraints"
}

variable "hostname" {
  type = string

  description = "Public access FQDN for Rudderstack dispatcher"
}

variable "internal_root_domain" {
  type = string

  description = "Root domain for internal access"
}

variable "istio_gateway" {
  type = string

  description = "Name of the upstream Istio gateway in form of <namespace>/<gateway>"
}
