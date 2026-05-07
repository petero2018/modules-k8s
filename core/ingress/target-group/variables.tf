variable "ingress_name" {
  type = string

  description = "Free-form name of the ingress configuration."
}

variable "target_group_arn" {
  type = string

  description = "ARN of the AWS lb target group to attach this ingress."

  validation {
    condition     = substr(var.target_group_arn, 0, 29) == "arn:aws:elasticloadbalancing:"
    error_message = "Valid ARN format required!"
  }
}

variable "namespace" {
  type = string

  description = "Namespace to install Kubernetes TargetGroupBinding custom resource."
}

variable "service_name" {
  type = string

  description = "Name of the Kubernetes service to use."
}

variable "service_port" {
  type = number

  description = "Number of port configured on the Kubernetes service."

  validation {
    condition     = var.service_port >= 1 && var.service_port <= 65535
    error_message = "Valid port number needed!"
  }
}
