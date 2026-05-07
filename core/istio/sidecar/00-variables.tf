variable "namespace" {
  type        = string
  description = "Namespace where the resource will be created."
}

variable "name" {
  type        = string
  description = "Name for the resource that will be created."
}

variable "hosts" {
  type        = list(string)
  description = "Hosts to be set on the egress allow-list."
}
