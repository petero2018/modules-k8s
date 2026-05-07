################################################################################
# Wait Resource
################################################################################

variable "name" {
  description = "Name of the resource to wait."
  type        = string
}

variable "namespace" {
  description = "Namespace where the resource to wait is in."
  type        = string
}

variable "resource" {
  description = "Resource kind to look."
  type        = string
}

variable "json_path" {
  description = "JSON Path to look for in the resource"
  type        = string
}

variable "expected_value" {
  description = "Expected value to look on the json resource to validate it."
  type        = string
}

variable "error_message" {
  description = "Error message to show when the wait times out."
  type        = string
}

variable "step_time" {
  description = "Time to wait between checks."
  type        = number
  default     = 5
}

variable "timeout" {
  description = "Timeout of the wait."
  type        = number
  default     = 60
}

variable "wait_trigger" {
  description = "String to trigger resource wait, usually the resource body."
  type        = string
}

variable "eks_cluster" {
  description = "EKS cluster name, needed to wait resource creation."
  type        = string
}
