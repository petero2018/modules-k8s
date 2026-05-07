variable "name" {
  type        = string
  description = "Name of the metric template."
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace to install the metric template."
  default     = "flagger"
}

variable "type" {
  type        = string
  description = "Type of the metric template (e.g.: \"datadog\" or \"prometheus\"). Assumes \"datadog\" by default."
  default     = "datadog"
}

variable "address" {
  type        = string
  description = "Address of where the metrics are retrieved (e.g.: \"https://api.datadoghq.com\" or \"http://prometheus.istio-system:9090\"). Assumes \"https://api.datadoghq.com\" by default."
  default     = "https://api.datadoghq.com"
}

variable "secret_name" {
  type        = string
  description = "Secret name of the credentials to access the metrics. Default is \"datadog\"."
  default     = "datadog"
}

variable "query" {
  type        = string
  description = "Metric query used for the canary deployment."
}
