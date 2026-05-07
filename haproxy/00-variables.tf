variable "name" {
  type = string

  description = "Name of the HAProxy installation."
}

variable "namespace" {
  type = string

  description = "Namespace where we will deploy HAProxy."
}

variable "image" {
  type = string

  default     = "567716553783.dkr.ecr.us-east-1.amazonaws.com/haproxy:2.4.3"
  description = "HAProxy container image."
}

variable "backend" {
  type = string

  description = "Backend service to route traffic into."
}

variable "replicas" {
  type = number

  default     = 2
  description = "Spin this number of HAProxy pods in the beginning."
}

variable "min_replicas" {
  type = number

  default     = 2
  description = "Min number of HAProxy pods."
}

variable "max_replicas" {
  type = number

  default     = 8
  description = "Max number of HAProxy pods."
}

variable "requests" {
  type = object({ cpu = string, memory = string })

  default     = ({ cpu = "250m", memory = "256Mi" })
  description = "HAProxy container resource requests."
}

variable "limits" {
  type = object({ cpu = string, memory = string })

  default     = ({ cpu = "1000m", memory = "1024Mi" })
  description = "HAProxy container resource limits."
}

variable "timeouts" {
  type = object({ create = string, update = string, delete = string })

  default     = ({ create = "20m", update = "20m", delete = "10m" })
  description = "Timeouts for create/update/delete deployment operations."
}
