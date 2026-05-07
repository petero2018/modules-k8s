variable "name" {
  type        = string
  description = "Name of the istio ingress gateway chart release."
}

variable "service_name" {
  type        = string
  description = "Name of the istio ingress gateway service."

  default = "istio-ingressgateway"
}

variable "namespace" {
  type = string

  description = "Namespace to install istio ingress gateway chart."
}

variable "istio_version" {
  type = string

  description = "istio version to install."

  validation {
    condition     = can(regex("^1\\.[0-9]+\\.[0-9]+$", var.istio_version))
    error_message = "Invalid version format."
  }
}

variable "eks_auto_mode" {
  type        = bool
  default     = false
  description = "Use EKS Auto Mode CRDs."
}

variable "min_pods" {
  type        = number
  default     = 2
  description = "Minimum number of pods."
}

variable "max_pods" {
  type        = number
  default     = 32
  description = "Maximum number of pods."
}

variable "anti_affinity" {
  type = object({
    per_az = optional(object({
      enable = optional(bool, true)
      hard   = optional(bool, false) # This should never be on unless you don't plan for more than 3 pods
    }), {})
    per_host = optional(object({
      enable = optional(bool, true)
      hard   = optional(bool, false) # This will require 1 host per pod, which can be a lot depending on the scale
    }), {})
  })
  default     = {}
  description = "Pod anti affinity settings."
}

variable "ingress_labels" {
  type        = map(string)
  default     = { "istio" : "ingressgateway" }
  description = "Ingress labels to use on the Gateway selector."
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

variable "load_balancer_scheme" {
  type        = string
  default     = "internal"
  description = "Load balancer scheme. Specifies whether the NLB will be \"internet-facing\" or \"internal\"."

  validation {
    condition     = contains(["internal", "internet-facing"], var.load_balancer_scheme)
    error_message = "Unsupported load balancer scheme!"
  }
}

variable "keep_source_ip" {
  type        = bool
  default     = false
  description = "Keep the source IP to pass on the request for istio ingress gateway (relevant only for LoadBalancer service type)."
}

variable "acm_certificate_arn" {
  type        = string
  default     = null
  description = "ACM certificate ARN to use on the load balancer (relevant only for LoadBalancer service type)."
}

variable "target_groups" {
  type = map(object({
    arn  = string
    port = optional(number, 443)
  }))
  default     = {}
  description = "Map of target groups: name => (target group ARN, TCP port)."
}

variable "num_trusted_proxies" {
  type        = number
  default     = 0
  description = "Number of trusted reverse proxies in front of the istio ingress gateway, to fetch source IP from the X-Forwarded-For header."

  validation {
    condition     = var.num_trusted_proxies >= 0
    error_message = "Number of trusted proxies should be 0 or more."
  }
}

variable "istio_charts_path" {
  type        = string
  default     = null
  description = "Local path to install istio ingress gateway chart from (will try to download, if null)"
}

variable "load_balancer_healthcheck_port" {
  type = string
  # https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.2/guide/service/annotations/#annotations
  default     = "traffic-port"
  description = "Port to be used for healthcheck by the load balancer associated with istio's ingress gateway (relevant only for LoadBalancer service type)."
}

variable "termination_drain_duration" {
  type        = string
  default     = "30"
  description = "Termination drain duration in seconds. By default it is 30 seconds to match the default termination grace period set on the pods."
}

variable "hub" {
  type = string

  description = "Container registry hub."
  default     = null
}

variable "aws_iam_role_arn" {
  type = string

  description = "The AWS IAM role to associate with the ingressgateway service account (requires OIDC / IRSA to be setup on the cluster)"
  default     = null

  validation {
    condition = anytrue([
      var.aws_iam_role_arn == null,
      can(regex("arn:aws:iam::[0-9]{12}:role/.+", var.aws_iam_role_arn))
    ])
    error_message = "Invalid IAM role ARN."
  }
}

variable "enable_csi" {
  type = bool

  description = "Setting this to true will make the Istio gateway mount its ingressgateway-certs directory from a SecretProviderClass called ingressgateway-certs, using the secrets-store.csi driver. An appropriate IRSA setup (using aws_iam_role_arn) is required to use this properly."
  default     = false
}

variable "deploy_arch" {
  type        = string
  description = "Node architecture to deploy to. Must be either \"amd64\" or \"arm64\""
  default     = "amd64"

  validation {
    condition     = contains(["amd64", "arm64"], var.deploy_arch)
    error_message = "Valid values for node architecture are: (amd64, arm64)"
  }
}

variable "capacity_type_selector" {
  type = object({
    key   = optional(string, "eks\\.amazonaws\\.com/capacityType")
    value = optional(string, "ON_DEMAND")
  })

  description = "The key and value used for the nodeSelector for Istio control plane components."
}

variable "extra_ports" {
  type = list(object({
    name       = string
    port       = number
    targetPort = number
    protocol   = string
  }))
  default     = []
  description = "List of extra ports that the ingress gateway pods will listen on."
}
