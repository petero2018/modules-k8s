################################################################################
# Helm Config
################################################################################

variable "namespace" {
  type = string

  default     = "datadog"
  description = "The namespace to install the components in."
}

variable "create_namespace" {
  type = bool

  default     = true
  description = "Create the namespace if it does not yet exist."
}

variable "chart_version" {
  type = string

  description = "The version of External Secrets Operator to install."
}

variable "helm_config" {
  type = any

  default     = {}
  description = "Helm provider config for External Secrets Operator"
}

variable "timeout" {
  type = number

  default     = 600
  description = "Time in seconds to wait for release installation."
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
# DataDog Keys
################################################################################

variable "datadog_api_key" {
  type        = string
  sensitive   = true
  default     = null
  description = "Datadog API key."
}

variable "datadog_app_key" {
  type        = string
  sensitive   = true
  default     = null
  description = "Datadog application key."
}

################################################################################
# DataDog Configs
################################################################################

variable "eks_cluster" {
  type = string

  description = "Unique cluster name to allow scoping hosts and Cluster Checks easily."
}

variable "agent_iam_policy_arns" {
  type = list(string)

  default     = []
  description = "List of IAM policy ARNs to attach to the agent role."
}

variable "environment" {
  type = string

  default     = null
  description = "Environment name to group all the metrics in an environment tag."
}

variable "region" {
  type = string

  description = "Region name to group the metrics in a region tag."
}

variable "datadog_site" {
  type = string

  default     = "datadoghq.com" # See https://docs.datadoghq.com/getting_started/site/ for possible values
  description = "Datadog site (i.e. region) domain where to send the data."
}

variable "kube_status" {
  type = string

  default     = null
  description = "Define it if you want to get metrics grouped in a `kube_status` tag."
}

variable "product" {
  type = string

  default     = null
  description = "Define it if you want to get metrics grouped in a `product` tag."
}

variable "custom_tags" {
  type = list(string)

  default     = []
  description = "Custom tags to add to the metrics"
}

variable "log_level" {
  type = string

  default     = "WARN"
  description = "Set logging verbosity, valid log levels are: trace, debug, info, warn, error, critical, off"

  validation {
    condition     = contains(["TRACE", "DEBUG", "INFO", "WARN", "ERROR", "CRITICAL", "OFF"], var.log_level)
    error_message = "Valid log levels are: trace, debug, info, warn, error, critical, off."
  }
}

variable "pod_labels_as_tags" {
  type = map(string)

  default = {
    "is-ephemeral" = "kube_is_ephemeral"
    "team"         = "team"
    "impact"       = "impact"
    "service"      = "app"
  }
  description = "Maps pod labels as datadog tags."
}

variable "datadog_checks_cardinality" {
  description = "Add tags to check metrics (low, orchestrator, high). More info here: https://docs.datadoghq.com/getting_started/tagging/assigning_tags/?tab=containerizedenvironments#environment-variables"
  type        = string
  default     = "low"
  validation {
    condition     = contains(["low", "orchestrator", "high"], var.datadog_checks_cardinality)
    error_message = "Illegal datadog cardinality."
  }
}

variable "enable_apm" {
  type = bool

  default     = false
  description = "Enables APM Agent."
}

variable "enable_logs" {
  type = bool

  default     = false
  description = "Enables Logs Agent. And collect all the logs."
}

variable "enable_process_agent" {
  type = bool

  default     = false
  description = "Enables Process Agent."
}

variable "agent_tolerations" {
  type = list(object({
    key      = optional(string)
    operator = string
    effect   = optional(string)
  }))

  default = [
    {
      operator = "Exists"
    },
  ]
  description = "Allow the Cluster Agent Deployment to schedule on tainted nodes."
}

variable "use_custom_image" {
  type = bool

  default     = false
  description = "Whether to use the custom powise-managed Agent with the Gatekeeper integration enabled."
}

variable "dd_external_metrics_provider_max_age" {
  type = string

  default     = "120"
  description = "DD_EXTERNAL_METRICS_PROVIDER_MAX_AGE environment variable. Maximum age (in seconds) of a datapoint before considering it invalid to be served. Default to 120 seconds."
}

################################################################################
# Cluster checks
################################################################################

variable "msk_cluster_arns" {
  type = list(string)

  default     = []
  description = "List of AWS MSK Cluster ARNs used for Kafka Metrics."
}

variable "opensearch_urls" {
  type = list(object({
    url       = string
    auth_type = optional(string)
    region    = optional(string, null)
  }))

  default     = []
  description = "List of OpenSearch URLs to monitor."
}

variable "opensearch_arns" {
  type = list(string)

  default     = []
  description = "List of OpenSearch ARNs to allow the Datadog agent to monitor."
}

variable "clickhouse_clusters" {
  type = list(object({
    name          = string
    replica_hosts = list(string)
    port          = optional(number, 9440)
    username      = string
    password      = string
  }))
  sensitive   = true
  description = "List of ClickHouse clusters to monitor."
}

################################################################################
# Custom template (this will ignore all the config)
################################################################################

variable "template_file" {
  type = string

  default     = ""
  description = "The template file to use for datadog. If no template file is specified it will use the default one."
}

variable "template_values" {
  type = map(string)

  default     = {}
  description = "The values to use for resolve the template."
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "Tags to identify resource ownership."

  type = object({
    team    = string
    impact  = string
    service = string
  })

  validation {
    condition = alltrue([
      contains(keys(var.tags), "team"),
      contains(keys(var.tags), "service"),
      contains(keys(var.tags), "impact"),
    ])

    error_message = "Required tags are missing! Please provide tags 'team', 'service' and 'impact'."
  }
}
