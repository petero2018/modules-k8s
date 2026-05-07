variable "hpa_name" {
  type = string

  description = "Name of the HorizontalPodAutoscaler object provisioned."
}

variable "namespace" {
  type = string

  description = "Namespace where we place HorizontalPodAutoscaler."
}

variable "scaling" {
  type = object({
    min_replicas   = number
    max_replicas   = number
    resource_name  = string
    utilization    = number
    scale_up_pods  = optional(number),
    window_seconds = optional(number)
    period_seconds = optional(number)
  })

  description = "Scaling behavior config."

  validation {
    condition     = var.scaling.min_replicas > 0
    error_message = "\"scaling.min_replicas\" should be > 0."
  }

  validation {
    condition     = var.scaling.max_replicas >= var.scaling.min_replicas
    error_message = "\"scaling.max_replicas\" should be greater than \"scaling.min_replicas\"."
  }

  validation {
    condition     = contains(["cpu", "memory"], var.scaling.resource_name)
    error_message = "\"scaling.resource_name\" should be \"cpu\" or \"memory\"."
  }

  validation {
    condition     = var.scaling.utilization > 0 && var.scaling.utilization <= 100
    error_message = "\"scaling.utilization\" should be in the 1-100(%) range."
  }

  validation {
    condition     = var.scaling.scale_up_pods > 0 && var.scaling.scale_up_pods <= 10
    error_message = "\"scaling.scale_up_pods\" should be in the 1-10 range."
  }

  validation {
    condition     = var.scaling.window_seconds < 3600
    error_message = "\"scaling.window_seconds\" should be less than 3600 (1 hour)."
  }

  validation {
    condition     = var.scaling.period_seconds < 1800
    error_message = "\"scaling.period_seconds\" should be less than 1800 (30 min)."
  }
}

variable "target" {
  type = object({
    api_version = optional(string)
    kind        = string
    name        = string
  })

  validation {
    condition     = contains(["Deployment", "StatefulSet"], var.target.kind)
    error_message = "\"target.kind\" should be \"Deployment\" or \"StatefulSet\"."
  }

  description = "Autoscaling target settings."
}
