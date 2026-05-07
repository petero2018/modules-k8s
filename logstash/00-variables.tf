################################################################################
# Helm Config
################################################################################

variable "namespace" {
  type = string

  default     = "logstash"
  description = "The namespace to install the components in."
}

variable "create_namespace" {
  type = bool

  default     = true
  description = "Create the namespace if it does not yet exist."
}

variable "chart_version" {
  type = string

  description = "The version of Logstash to install."
}

variable "helm_config" {
  type = any

  default     = {}
  description = "Helm provider config for Kubecost"
}

variable "timeout" {
  type = number

  default     = 600
  description = "Time in seconds to wait for release installation."
}

variable "name" {
  type        = string
  default     = "logstash"
  description = "Name of the installation, used for ServiceAccount & IAM role names."
}

################################################################################
# ArgoCD Config
################################################################################

variable "manage_via_argocd" {
  description = "Determines if the release should be managed via ArgoCD."
  type        = bool
  default     = false
}

variable "argocd_app_config" {
  description = "ArgoCD Application config. See k8s/argocd/resources/application"
  type        = any
  default     = {}
}

################################################################################
# Logstash Config
################################################################################

variable "logstash_version" {
  type        = string
  default     = "8.6.1"
  description = "The version of the logstash image to use."

  validation {
    condition     = length(split(".", var.logstash_version)) == 3
    error_message = "Version string must specify a major, minor and patch version that matches the logstash image tag."
  }
}

variable "image_repository" {
  type        = string
  default     = "opensearchproject/logstash-oss-with-opensearch-output-plugin"
  description = "Docker image repository for Logstash."
}

variable "enable_ecs_compatibility" {
  type        = string
  default     = "disabled"
  description = "Whether to enable Elasic Common Schema compatibility mode"

  validation {
    condition     = contains(["disabled", "v8", "v1"], var.enable_ecs_compatibility)
    error_message = "ECS Compatibility must either be \"disabled\", or set to \"v8\" or \"v1\"."
  }
}
variable "replicas" {
  type        = number
  default     = 3
  description = "How many instances of logstash to run in the statefulset."
}

variable "max_unavailable" {
  type        = number
  default     = 1
  description = "The maximum number of Logstash pods that can be unavailable during an update or disruption."
}

variable "opensearch_arns" {
  type        = list(string)
  description = "A list of opensearch cluster ARNs into which logstash will be granted permission to send logs."
}

variable "enable_iam" {
  type        = bool
  default     = true
  description = "Authenticate to the opensearch endpoint(s) via IAM permissions"
}

variable "iam_prefix" {
  type        = string
  default     = "logstash"
  description = "First part of the IAM role name."
}

variable "iam_suffix" {
  type        = string
  default     = null
  description = "Will be appended to the end of IAM-related resources to help maintain uniqueness in multi-cluster/multi-region setups"
}

variable "enable_multiple_pipeline_support" {
  type        = bool
  default     = false
  description = "If set to true, each entry in the pipelines variable run as a separate pipeline"
}

variable "pipelines" {
  type        = map(string)
  default     = {}
  description = "Pipelines that will be injected into the applicable configmap"
}

variable "patterns" {
  type        = map(string)
  default     = {}
  description = "Patterns that will be injected into the configmap and used by Logstash to parse logs"
}

variable "ports" {
  type = list(object({
    name           = string
    container_port = number
  }))
  default     = []
  description = "Each port required by pipelines must be configured here to allow ingress"
}

variable "extra_iam_policies" {
  type        = map(string)
  default     = {}
  description = "Additional IAM policies that will be attached to Logstash's IAM role"
}

variable "pipeline_batch_size" {
  type        = number
  default     = 125
  description = "Maximum pipeline batch size."
}

variable "pipeline_workers" {
  type        = number
  default     = null
  description = "Set the number of pipeline workers, optional (defaults to the number of CPUs)."
}

################################################################################
# Resource usage
################################################################################

variable "java_opts" {
  type        = string
  default     = "-Xmx1g -Xms1g"
  description = "Logstash JVM memory settings."
}

variable "resource_requests" {
  type = object({
    cpu    = optional(string, "100m")
    memory = optional(string, "1792Mi")
  })
  default     = {}
  description = "Logstash pods resource requests."
}

variable "resource_limits" {
  type = object({
    cpu    = optional(string, "1000m")
    memory = optional(string, "1792Mi")
  })
  default     = {}
  description = "Logstash pods resource limits."
}

################################################################################
# Misc Config
################################################################################

variable "enable_istio" {
  type        = bool
  default     = false
  description = "Whether to add logstash to the cluster's Istio service mesh."
}

variable "eks_cluster" {
  type        = string
  description = "The EKS cluster in which Logstash will be installed."
}

variable "deploy_arch" {
  type        = string
  description = "Node architecture to deploy to. Must be either \"amd64\" or \"arm64\""

  default = "arm64"
  validation {
    condition     = contains(["amd64", "arm64"], var.deploy_arch)
    error_message = "Valid values for node architecture are: (amd64, arm64)"
  }
}

variable "tags" {
  description = "Tags to identify resources ownership"
  type        = map(string)
  validation {
    condition = alltrue([
      contains(keys(var.tags), "team"),
      contains(keys(var.tags), "service"),
      contains(keys(var.tags), "impact"),
    ])
    error_message = "\"tags\" must contain at least those tags: \"team\", \"impact\", \"service\"."
  }
}
