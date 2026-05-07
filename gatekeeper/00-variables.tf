##################################################
# Helm chart settings
##################################################

variable "chart_version" {
  type = string

  default     = "3.10.0"
  description = "The version of gatekeeper chart to install."
}

variable "namespace" {
  type = string

  default     = "gatekeeper-system"
  description = "The namespace in which Gatekeeper will be installed."
}

variable "create_namespace" {
  type = bool

  default     = true
  description = "Whether the namespace will be created by Helm."
}

variable "helm_set_values" {
  type = map(string)

  default     = {}
  description = "Value blocks to be merged with the values YAML and passed to the helm module."
}

variable "helm_values" {
  type = list(string)

  default     = []
  description = "List of values in raw yaml to pass to the helm module."
}

##################################################
# Gatekeeper Config settings
##################################################

variable "audit_interval" {
  type    = string
  default = 60

  description = "Specifies how often the audit service runs on the cluster. This should be tailored per-cluster so that audit runs do not overlap or cause excessive output."
}

variable "config_sync_data" {
  type = list(object({
    group   = string,
    version = string,
    kind    = string
  }))

  default = [
    {
      group   = ""
      kind    = "Namespace"
      version = "v1"
    },
    {
      group   = "security.istio.io"
      kind    = "PeerAuthentication"
      version = "v1beta1"
    },
    {
      group   = "security.istio.io"
      kind    = "AuthorizationPolicy"
      version = "v1beta1"
    }
  ]
  description = "A list of kubernetes resources that will be synced into Gatekeeper's cache, for the purposes of enriching data available to rules."
}

variable "config_match_data" {
  type = list(object({
    excludedNamespaces = list(string)
    processes          = list(string)
  }))

  default     = []
  description = "A list of namespace(s)/proccess(es) objects which will be excluded from Gatekeeper's actions at a cluster-level."
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
