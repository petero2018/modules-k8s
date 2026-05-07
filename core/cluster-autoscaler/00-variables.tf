variable "cluster_autoscaler_namespace" {
  type = string

  default     = "kube-system"
  description = "The namespace to install the components in."
}

variable "cluster_autoscaler_chart_version" {
  type = string

  description = "The version of cluster autoscaler chart to install."
}

variable "cluster_autoscaler_template_file" {
  type = string

  default     = ""
  description = "The template file to use for cluster autoscaler. If no template file is specified it will use the default one."
}

variable "cluster_autoscaler_template_values" {
  type = map(string)

  default     = {}
  description = "The values to use for resolve the template."
}

variable "cluster_autoscaler_helm_config" {
  type = any

  default     = {}
  description = "Helm provider config for cluster autoscaler"
}

variable "eks_cluster" {
  type = string

  description = "Name of the EKS cluster to deploy into."

  validation {
    condition     = length(split("-", var.eks_cluster)) == 2
    error_message = "Cluster name should be passed in ENV-CLUSTER form."
  }
}

variable "cluster_autoscaler_config" {
  type = object({
    scale_down_utilization_threshold = string,
    skip_nodes_with_local_storage    = bool,
    scale_down_unneeded_time         = string,
    image_tag                        = string
  })

  default = {
    scale_down_utilization_threshold = "0.6",
    skip_nodes_with_local_storage    = false,
    scale_down_unneeded_time         = "10m"
    image_tag                        = "v1.23.0"
  }

  description = "Cluster Autoscaler configuration."

  validation {
    condition     = split(".", var.cluster_autoscaler_config.image_tag)[0] == "v1"
    error_message = "\"image_tag\" should be set to a valid release: https://github.com/kubernetes/autoscaler/releases."
  }

  validation {
    condition     = contains(["0.5", "0.6", "0.7", "0.8", "0.9"], var.cluster_autoscaler_config.scale_down_utilization_threshold)
    error_message = "\"scale_down_utilization_threshold\" should be set to a sane value."
  }

  validation {
    condition     = contains(["1m", "2m", "3m", "4m", "5m", "10m"], var.cluster_autoscaler_config.scale_down_unneeded_time)
    error_message = "\"scale_down_unneeded_time\" should be set to a sane value."
  }
}

variable "timeout" {
  type = number

  default     = 600
  description = "Time in seconds to wait for release installation."
}
