variable "eks_cluster" {
  type = string

  description = "Name of the EKS cluster to deploy into."

  validation {
    condition     = length(split("-", var.eks_cluster)) == 2
    error_message = "Cluster name should be passed in ENV-CLUSTER form."
  }
}

variable "environment" {
  type = string

  description = "Deploy environment (\"dev\", \"prod\" or \"tools\")."

  validation {
    condition     = contains(["dev", "prod", "tools"], var.environment)
    error_message = "Illegal environment name."
  }
}

variable "product" {
  type = string

  description = "Name of the product deployed to this cluster."

  default = "generic"

  validation {
    condition     = contains(["generic", "powise", "videoask"], var.product)
    error_message = "Illegal product name."
  }
}

variable "datadog_environment" {
  type = string

  default     = null
  description = "Datadog environment tag override (use on inactive prod clusters to not confuse dashboards and monitors)."
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

variable "kube_status" {
  type = string

  default     = "active"
  description = "Cluster status. \"active\" or \"inactive\"?"

  validation {
    condition     = contains(["active", "inactive"], var.kube_status)
    error_message = "Illegal cluster status."
  }
}

variable "kube_proxy_version" {
  type = string

  default     = "v1.20.4-eksbuild.2"
  description = "\"kube-proxy\" EKS addon version."
}

variable "vpc_cni_version" {
  type = string

  default     = "v1.8.0-eksbuild.1"
  description = "\"VPC CNI\" EKS addon version."
}

variable "vpc_cni_chart_version" {
  type = string

  default     = "1.1.10"
  description = "\"VPC CNI\" EKS addon helm chart version."
}

variable "coredns_version" {
  type = string

  default     = "v1.8.3-eksbuild.1"
  description = "\"CoreDNS\" EKS addon version."
}

variable "logstash_redis_host" {
  type = string

  default     = "logstash-tfprod.zuxcwv.0001.use1.cache.amazonaws.com"
  description = "Host of the redis endpoint for filebeat output (logstash input)."
}

variable "datadog_chart_version" {
  type = string

  default     = "2.19.2"
  description = "A version of Datadog chart to install."
}

variable "datadog_api_key_ssm_path" {
  type = string

  default     = null
  description = "SSM parameter name (path) for the Datadog API key."
}

variable "datadog_app_key_ssm_path" {
  type = string

  default     = null
  description = "SSM parameter name (path) for the Datadog application key."
}

variable "enable_flagger" {
  type = bool

  default     = false
  description = "Enable Flagger, a progressive delivery tool (set \"true\" for dev and prod clusters)."
}

variable "flagger_chart_version" {
  type = string

  default     = "1.13.0"
  description = "Version of Flagger helm chart to install."
}

variable "filebeat_chart_version" {
  type = string

  default     = "7.13.2"
  description = "Version of Filebeat helm chart to install."
}

variable "enable_external_dns" {
  type = bool

  default     = false
  description = "Enable ExternalDNS component (set \"true\" for non-production clusters)."
}

variable "allow_external_dns_zone_ids" {
  type = list(string)

  default     = []
  description = "List of Route53 hosted zone IDs we allow ExternalDNS to access."
}

variable "enable_cluster_autoscaler" {
  type = bool

  default     = false
  description = "Enable Cluster Autoscaler component."
}

variable "cluster_autoscaler_config" {
  type = object({
    scale_down_utilization_threshold = string,
    skip_nodes_with_local_storage    = bool,
    scale_down_unneeded_time         = string,
  })

  default = {
    scale_down_utilization_threshold = "0.6",
    skip_nodes_with_local_storage    = false,
    scale_down_unneeded_time         = "10m",
  }

  description = "Cluster Autoscaler configuration."

  validation {
    condition     = contains(["0.5", "0.6", "0.7", "0.8", "0.9"], var.cluster_autoscaler_config.scale_down_utilization_threshold)
    error_message = "\"scale_down_utilization_threshold\" should be set to a sane value."
  }

  validation {
    condition     = contains(["1m", "2m", "3m", "4m", "5m", "10m"], var.cluster_autoscaler_config.scale_down_unneeded_time)
    error_message = "\"scale_down_unneeded_time\" should be set to a sane value."
  }
}

variable "overprovisioning_configs" {
  type = list(object({
    name            = string,
    node_group_name = string,
    min_replicas    = number,
    max_replicas    = number,
    slack_pct       = number,
  }))

  default     = [{ name = "overprovisioning", node_group_name = "", min_replicas = 20, max_replicas = 80, slack_pct = 20 }]
  description = "Config object for the cluster resource \"ballast\" buffers."

  validation {
    condition = alltrue([
      for oc in var.overprovisioning_configs : oc.max_replicas >= oc.min_replicas
    ])

    error_message = "\"max_replicas\" should be greater or equal than \"min_replicas\"."
  }

  validation {
    condition = alltrue([
      for oc in var.overprovisioning_configs : contains([10, 15, 20, 25, 30, 35, 40], oc.slack_pct)
    ])

    error_message = "\"slack_pct\" can be set to 10, 15, 20, 25, 30, 35 or 40 (percent value)."
  }
}

variable "enable_core_components_logs" {
  type = bool

  default     = false
  description = "Forward core component logs (e.g. kube-system components, datadog...) to ELK stack. Note: this only adds a field to Filebeat events, filtering is done in Logstash."
}

variable "enable_datadog_apm" {
  type = bool

  default     = false
  description = "Enable datadog APM and tracing."
}

variable "enable_datadog_logs" {
  type = bool

  default     = false
  description = "Enable datadog log collection."
}

variable "enable_security_group_policies" {
  type = bool

  default     = false
  description = "Enable security group policies (set \"true\" to support security groups for pods)."
}

variable "daemonset_helm_timeout" {
  type = number

  default     = 600
  description = "Timeout to install/update daemonset (Datadog and Filebeat) charts."
}

variable "aws_load_balancer_controller_chart_version" {
  type        = string
  description = "Chart version to deploy for AWS Load Balancer Controller."
}

# See: https://github.com/kubernetes/autoscaler/issues/4850
variable "aws_cluster_autoscaler_image_tag" {
  type        = string
  description = "Version to deploy for AWS Load Balancer Controller."
}


variable "aws_cluster_autoscaler_chart_version" {
  type        = string
  description = "Chart version to deploy for AWS Cluster Autoscaler."
}

variable "tags" {
  description = "Tags to identify resources ownership"
  type = object({
    team    = string
    impact  = string
    service = string
  })
}
