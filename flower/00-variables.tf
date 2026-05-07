variable "eks_cluster" {
  type        = string
  description = "EKS cluster flower will be deployed to."
}

variable "environment" {
  type        = string
  description = "Environment flower will be deploy to."
}

variable "deploy_arch" {
  type        = string
  description = "Node architecture to deploy to. Must be either \"amd64\" or \"arm64\""
  default     = "arm64"

  validation {
    condition     = contains(["amd64", "arm64"], var.deploy_arch)
    error_message = "Valid values for node architecture are: (amd64, arm64)"
  }
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to deploy security group to."
}

variable "flower_route53_record" {
  type        = string
  description = "Route53 record for flower."
}

variable "flower_docker_repository_url" {
  type        = string
  default     = "mher/flower"
  description = "Flower Docker repo to use."
}

variable "flower_docker_image_version" {
  type        = string
  description = "Version of the Flower docker image to deploy."
  default     = "98de8caab2a671837c3b65cdecb13e46b15980f8"
}

variable "flower_service_name" {
  type        = string
  description = "Name of deployed service."
  default     = "flower-celery"

  validation {
    condition     = var.flower_service_name != "flower"
    error_message = "The name of the service can't be just \"flower\" because of this issue: https://github.com/mher/flower/issues/738#issuecomment-330606229."
  }
}

variable "flower_container_http_port" {
  type        = number
  description = "HTTP port for flower service."
  default     = 5555
}

variable "flower_healthcheck_path" {
  type        = string
  description = "URI for flower deployment healthcheck."
  default     = "/healthcheck"
}

variable "flower_oauth2_key" {
  description = "OAuth2 key for flower."
  type        = string
}

variable "flower_oauth2_secret" {
  description = "OAuth2 secret for flower."
  type        = string
}

variable "restricted_ingress_gateway_namespace" {
  type        = string
  description = "Namespace of the restricted ingress gateway."
}

variable "restricted_ingress_gateway_name" {
  type        = string
  description = "Name of the restricted ingress gateway"
}

variable "redis_security_group_id" {
  type        = string
  description = "Security group id for Redis to allow access from flower pods."
}

variable "redis_address" {
  type        = string
  description = "Address for Redis instance used for Celery Broker URL."
}

variable "workers_security_group_id" {
  type        = string
  description = "Security group id for EKS workers."
}

variable "namespace" {
  type        = string
  description = "Namespace to deploy flower to."
}

variable "run_as_non_root" {
  type        = bool
  default     = false
  description = "Needs to be true in order to run the container as a non-root user"
}

variable "read_only_root_filesystem" {
  type        = bool
  default     = true
  description = "Whether to set root filesystem to ReadOnly."
}

variable "kms_key_id" {
  type        = string
  description = "KMS Key to ise to encrypt SSM parameters."
}

variable "tags" {
  description = "Tags to be applied to resources."
  type        = map(string)

  validation {
    condition = alltrue([
      contains(keys(var.tags), "team"),
      contains(keys(var.tags), "service"),
      contains(keys(var.tags), "impact"),
    ])
    error_message = "Required tags are missing! Please provide tags 'team', 'service' and 'impact'."
  }
}
