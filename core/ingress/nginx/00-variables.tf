################################################################################
# Release
################################################################################

variable "name" {
  type        = string
  default     = "nginx"
  description = "Name of the nginx ingress."
}

variable "namespace" {
  description = "The namespace to install the components in."
  default     = "kube-system"
  type        = string
}

variable "chart_version" {
  description = "The version of aws load balancer controller chart to install."
  type        = string
}

variable "helm_config" {
  description = "Helm provider config for aws load balancer controller"
  type        = any
  default     = {}
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
# Controller
################################################################################

variable "ingress_class_name" {
  type        = string
  default     = null
  description = "Name of the ingress class to create. By default the same as name"
}

variable "ingress_service_type" {
  type        = string
  default     = "ClusterIP"
  description = "Istio ingress service type to create on the cluster."

  validation {
    condition     = contains(["NodePort", "LoadBalancer", "ClusterIP"], var.ingress_service_type)
    error_message = "Unsupported ingress service type!"
  }
}

variable "ingress_service_annotations" {
  description = "Annotations to be applied to ingress service. (mainly to setup LoadBalancer if service type is LoadBalancer)."
  type        = map(string)
  default     = {}
}

variable "ingress_publish_service" {
  type        = bool
  default     = false
  description = "To announce the ingress service ip to ingress resources so that external-dns can collect them and create DNS entries."
}

variable "ingress_min_replicas" {
  type        = number
  default     = 2
  description = "Minimum number of ingress replicas."
}

variable "ingress_max_replicas" {
  type        = number
  default     = 6 #16
  description = "Maximum number of ingress replicas."
}

################################################################################
# Ingress
################################################################################

variable "target_group_type" {
  type        = string
  default     = "ip"
  description = "Target type for the target group."
}

variable "target_group_arn" {
  type        = string
  description = "Bind ingress service to an existing target groups ARN."
}

variable "http_target_group_arn" {
  type        = string
  default     = null
  description = "Bind ingress service to an existing HTTP target groups ARN."
}
