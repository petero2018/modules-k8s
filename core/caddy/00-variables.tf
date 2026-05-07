# Deployment settings
variable "name" {
  type        = string
  description = "Caddy installation name."
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace to install Caddy."
}

variable "replicas" {
  type        = number
  default     = 2
  description = "Number of replicas."
}

variable "role_arn" {
  type        = string
  description = "Role to be assumed by Caddy to reach the DynamoDB table."
}

variable "resources_requests" {
  type = object({
    cpu    = optional(string, "250m"),
    memory = optional(string, "256Mi"),
  })

  default = {}

  description = "Pod resources requests, in Kubernetes format."
}

variable "resources_limits" {
  type = object({
    cpu    = optional(string, "1000m"),
    memory = optional(string, "1024Mi"),
  })

  default = {}

  description = "Pod resources limits, in Kubernetes format."
}

# Caddy configuration
variable "certificates_email" {
  type        = string
  description = "Email used for certificate generation."
  default     = "ops+caddy@powise.com"
}

variable "confirmation_endpoint_url" {
  type        = string
  description = "Endpoint URL to confirm which domains can have their certificate generated."
}

variable "dynamodb_table_name" {
  type        = string
  description = "DynamoDB table name to store certificates."
}

variable "proxied_host" {
  type        = string
  description = "Service host behind the Caddy reverse proxy."
}

variable "proxied_port" {
  type        = number
  description = "Port of the service being proxied."
}

variable "alias_domain" {
  type        = string
  description = "Alias domain that custom domains have their CNAME set to (e.g. 'alias.videoask.com')."
}

variable "allowed_cidrs" {
  type        = list(string)
  description = "List of allowed CIDR ranges."
  default     = []
}

variable "disable_http_challenge" {
  type        = bool
  description = "Whether to disable the HTTP challenge for certificate generation."
  default     = false
}

variable "disable_tls_alpn_challenge" {
  type        = bool
  description = "Whether to disable the TLS-ALPN challenge for certificate generation."
  default     = false
}

variable "log_level" {
  type        = string
  description = "Caddy log level, see https://caddyserver.com/docs/json/logging/logs/level/ for acceptable values."
  default     = "DEBUG"
}

# Docker image
variable "docker_image_repository" {
  type        = string
  description = "Docker image repository."
  default     = "567716553783.dkr.ecr.us-east-1.amazonaws.com/caddy"
}

variable "docker_image_tag" {
  type        = string
  description = "Docker image tag."
  default     = "latest"
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

variable "tolerations" {
  type = list(object({
    key      = optional(string)
    operator = optional(string)
    value    = optional(string)
    effect   = optional(string)
  }))
  default     = []
  description = "Pod tolerations."
}
