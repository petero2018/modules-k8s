################################################################################
# Deployment Config
################################################################################

variable "namespace" {
  type = string

  default     = "fluentbit"
  description = "The namespace to install the components in."
}

variable "create_namespace" {
  type = bool

  default     = true
  description = "Create the namespace if it does not yet exist."
}

variable "chart_version" {
  type = string

  description = "The Helm Release Version to install."
}

variable "timeout" {
  type = number

  default     = 600
  description = "Time in seconds to wait for release installation."
}

variable "eks_cluster" {
  type = string

  description = "EKS cluster name, needed to wait resource creation."
}

variable "aws_region" {
  type = string

  description = "AWS region where to deploy."
}

variable "tolerations" {
  type = list(object({
    key      = string
    operator = string
    effect   = string
  }))

  default = [
    {
      key      = "dedicated"
      operator = "Exists"
      effect   = "NoExecute"
    },
    {
      key      = "jenkins"
      operator = "Exists"
      effect   = "NoExecute"
    },
    {
      key      = "architecture"
      operator = "Exists"
      effect   = "NoExecute"
    }
  ]
  description = "Set fluentbit tolerations."
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
# Fluentbit Inputs
################################################################################

variable "application_tag" {
  type = string

  default     = "application"
  description = "Application tag prefix. Tag applied to all containers not matching a group."
}

variable "application_ignore" {
  type = list(string)

  default     = ["fluentbit"]
  description = "Ignore containers with those names."
}

variable "container_groups" {
  type = map(list(string))

  default     = {}
  description = "Container groups. key is the tag and the value the list of containers (with wildcards *)."
}

variable "container_config" {
  type = object({
    parser           = string # Parser to use for applications
    mem_buf_limit    = string # Buffer memory limit
    skip_long_lines  = bool   # Avoids stop monitoring on buffer overflow for a line
    refresh_interval = number # The interval of refreshing the list of watched files in seconds.
    rotate_wait      = number # grace period for rotated files
  })

  default = {
    parser           = "cri"
    mem_buf_limit    = "5MB"
    skip_long_lines  = true
    refresh_interval = 10
    rotate_wait      = 30
  }
  description = "Container logs input configuration."
}

variable "host_logs_enabled" {
  type = bool

  default     = true
  description = "Capture logs from host."
}

variable "host_logs" {
  type = map(string)

  default = {
    dmesg    = "/var/log/dmesg"
    messages = "/var/log/messages"
    secure   = "/var/log/secure"
  }
  description = "Host logs to capture."
}

variable "host_config" {
  type = object({
    tag_prefix       = string # Tag to use for host logs as a prefix
    parser           = string # Parser to use for host files
    skip_long_lines  = bool   # Avoids stop monitoring on buffer overflow for a line
    mem_buf_limit    = string # Buffer memory limit (on each file)
    refresh_interval = number # The interval of refreshing the list of watched files in seconds.
  })

  default = {
    tag_prefix       = "host"
    parser           = "syslog"
    skip_long_lines  = true
    mem_buf_limit    = "5MB"
    refresh_interval = 10
  }
  description = "Input configuration for host files."
}

variable "systemd_logs_enabled" {
  type = bool

  default     = true
  description = "Capture logs from systemd."
}

variable "systemd_tag" {
  type = string

  default     = "systemd"
  description = "Systemd tag prefix."
}

variable "systemd_units" {
  type = list(string)

  default     = ["docker.service", "kubelet.service"]
  description = "Dataplane Systemd units. Empty list capture all logs."
}

variable "dataplane_logs_enabled" {
  type = bool

  default     = true
  description = "Capture dataplane logs."
}

variable "dataplane_tag" {
  type = string

  default     = "dataplane"
  description = "Dataplane logs tag."
}

variable "dataplane_containers" {
  type = list(string)

  default     = ["aws-node", "kube-proxy"]
  description = "Container prefix for dataplane services."
}

variable "dataplane_container_ignore" {
  type = list(string)

  default     = []
  description = "Container list to ignore."
}

################################################################################
# Fluentbit Parsers
################################################################################

variable "parsers" {
  type = map(object({
    format      = string
    regex       = optional(string)
    time_key    = string
    time_format = string
  }))

  default = {
    "cri" = {
      format      = "regex"
      regex       = <<REGEX
^(?<time>[^ ]+) (?<stream>stdout|stderr) (?<logtag>[^ ]*) (?<log>.*)$
REGEX
      time_key    = "time"
      time_format = "%Y-%m-%dT%H:%M:%S.%L%z"
    },
    "syslog" = {
      format      = "regex"
      regex       = <<REGEX
^(?<time>[^ ]* {1,2}[^ ]* [^ ]*) (?<host>[^ ]*) (?<ident>[a-zA-Z0-9_\/\.\-]*)(?:\[(?<pid>[0-9]+)\])?(?:[^\:]*\:)? *(?<message>.*)$
REGEX
      time_key    = "time"
      time_format = "%b %d %H:%M:%S"
    }
  }
  description = "Fluentbit parsers"
}

################################################################################
# Fluentbit Filters
################################################################################

variable "aws_metadata_enabled" {
  type = bool

  default     = true
  description = "Adds AWS metadata to the logs."
}

variable "aws_metadata_config" {
  type = object({
    az                = bool
    ec2_instance_id   = bool
    ec2_instance_type = bool
    private_ip        = bool
    ami_id            = bool
    account_id        = bool
    hostname          = bool
    vpc_id            = bool
    imds_version      = string
  })

  default = {
    az                = true
    ec2_instance_id   = true
    ec2_instance_type = true
    private_ip        = false
    ami_id            = false
    account_id        = false
    hostname          = false
    vpc_id            = false
    imds_version      = "v2"
  }
  description = "AWS metadata configuration."
}

variable "kubernetes_metadata_enabled" {
  type = bool

  default     = true
  description = "Adds Kubernetes metadata to the logs."
}

variable "kubernetes_metadata_config" {
  type = object({
    labels      = bool
    annotations = bool
  })

  default = {
    labels      = true
    annotations = true
  }
  description = "Which Extra Kubernetes metadata should be added to log events."
}

variable "static_fields" {
  type        = map(string)
  default     = {}
  description = "Map of static fields to add to all logs."
}

##############################################################################
# Fluentbit OpenSearch Output
################################################################################

variable "debug_output_enabled" {
  type = bool

  default     = false
  description = "Enables debug output (stdout)."
}

variable "opensearch_output_enabled" {
  type = bool

  default     = true
  description = "Enables OpenSearch Output."
}

variable "opensearch_host" {
  type = string

  default     = null
  description = "Hostname of the target OpenSearch instance."
}

variable "opensearch_index" {
  type = string

  default     = "k8s"
  description = "Index name."
}

##############################################################################
# Fluentbit S3 Output
################################################################################

variable "s3_output_enabled" {
  type = bool

  default     = true
  description = "Enables S3 Output."
}

variable "s3_bucket" {
  type = string

  default     = null
  description = "S3 Bucket to store data."
}

variable "s3_key_prefix" {
  type = string

  default     = "k8s"
  description = "S3 Key Prefix to use."
}

variable "s3_key_format" {
  type = string

  default     = "%Y/%m/%d/%H_%M_%S/$TAG-$UUID.gz"
  description = "Key format to use after key prefix."
}

variable "s3_compression" {
  type = string

  default     = "gzip"
  description = "Compression to use on the files."
}

variable "s3_file_size" {
  type = string

  default     = "50M"
  description = "Specifies the size of files in S3."
}

##############################################################################
# Fluentbit Kafka Output
################################################################################

variable "kafka_output_enabled" {
  type = bool

  default     = false
  description = "Enables the Kafka output."
}

variable "kafka_brokers" {
  type = string

  default     = null
  description = "Kafka bootstrap brokers string."
}

variable "kafka_topic" {
  type = string

  default     = null
  description = "Kafka topic to write logs."
}

variable "kafka_username" {
  type = string

  default     = null
  sensitive   = true
  description = "Kafka SCRAM username."
}

variable "kafka_password" {
  type = string

  default     = null
  sensitive   = true
  description = "Kafka SCRAM password."
}

################################################################################
# Tags
################################################################################

variable "tags" {
  description = "Tags to be applied to AWS resources."
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
