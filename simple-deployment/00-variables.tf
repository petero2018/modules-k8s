variable "eks_cluster" {
  type = string

  description = "Name of the EKS cluster we deploy application into."
}

variable "namespace" {
  type = string

  description = "Kubernetes namespace to deploy into."
}

variable "create_namespace" {
  type    = bool
  default = false

  description = "Whether to create the namespace."
}

variable "name" {
  type = string

  description = "Name of the application (Kubernetes deployment/service/serviceaccount will be named accordingly)."
}

variable "environment" {
  type = string

  description = "Application environment, e.g. \"tfprod\" or \"dev\", or \"tools\"."
}

variable "replicas" {
  type = number

  default     = 1
  description = "Number of replicas for the application Kubernetes deployment."
}

variable "app_image_repo" {
  type = string

  description = "Docker repository to pull application image from."
}

variable "app_image_tag" {
  type = string

  description = "Tag of the application Docker image (tag = application version)."

}

variable "command" {
  type = list(string)

  default     = []
  description = "Run application container with this command or leave empty to run container's own command."
}

variable "args" {
  type = list(string)

  default     = []
  description = "Pass arguments to application container's command (if you need it)."
}

variable "env" {
  type = map(string)

  default     = {}
  description = "Populate container environment variables with map of <env var name>:<env var value> key/value pairs."
}

variable "env_from_field_ref" {
  type = map(object({
    api_version = string,
    field_path  = string,
  }))

  default     = {}
  description = "Populate container environment variables with map of <env var name>:{api_version: <api_version>, field_path: <field_pathm>}}."
}

variable "env_from_ssm_secrets" {
  type = list(string)

  default     = []
  description = "Populate container environment variables with the secrets loaded from SSM (set absolute SSM parameter path to override \"ssm_secrets_path\" prefix)."
}

variable "backend_port" {
  type = number

  default     = 80
  description = "Application internal [non-ingress] port to communicate inside cluster."
}

variable "backend_https" {
  type = bool

  default     = false
  description = "Does in-cluster service uses HTTPS? (by default it should use HTTP)"
}

variable "requests" {
  type = object({ cpu = string, memory = string, ephemeral-storage = string })

  default     = { cpu = "0.5", memory = "512Mi", ephemeral-storage = "2Gi" }
  description = "Resources to be requested from Kubernetes cluster for each application container running."
}

variable "limits" {
  type = object({ cpu = string, memory = string, ephemeral-storage = string })

  default     = { cpu = "1", memory = "1024Mi", ephemeral-storage = "4Gi" }
  description = "Maximum cluster resource usage for a single application container."
}

variable "dind_requests" {
  type = object({ cpu = string, memory = string, ephemeral-storage = string })

  default     = { cpu = "0.5", memory = "512Mi", ephemeral-storage = "2Gi" }
  description = "Resources to be requested from Kubernetes cluster for each application container running."
}

variable "dind_limits" {
  type = object({ cpu = string, memory = string, ephemeral-storage = string })

  default     = { cpu = "1", memory = "1024Mi", ephemeral-storage = "4Gi" }
  description = "Maximum cluster resource usage for a single application container."
}

variable "readiness_probes" {
  type = map(
    object({
      port = number,
      path = string,
      tls  = bool,
  }))

  default     = {}
  description = "HTTP probes to determine if container is ready to serve traffic."
}

variable "liveness_probes" {
  type = map(
    object({
      port = number,
      path = string,
      tls  = bool,
  }))

  default     = {}
  description = "HTTP probes to determine if container is alive."
}

variable "image_pull_secrets" {
  type = list(string)

  default     = ["common-image-pull"]
  description = "A list of Docker registry access secrets to use for pulling application images."
}

variable "image_pull_policy" {
  type = string

  default     = "IfNotPresent"
  description = "When to pull app Docker image? Set to \"IfNotPresent\", \"Always\" or \"Never\"."
}

variable "ingress" {
  type = object({
    enabled           = bool,
    fqdn              = string,
    certificate_arns  = list(string),
    healthcheck_path  = string,
    allow_cidr_blocks = list(string),
  })

  default = {
    enabled           = false,
    fqdn              = "",
    certificate_arns  = [],
    healthcheck_path  = "/health",
    allow_cidr_blocks = [],
  }

  description = "Ingress configuration for the deployed application."
}

variable "internal_ingress" {
  type = object({
    enabled           = bool,
    fqdn              = string,
    certificate_arns  = list(string),
    healthcheck_path  = string,
    allow_cidr_blocks = list(string),
  })

  default = {
    enabled           = false,
    fqdn              = "",
    certificate_arns  = [],
    healthcheck_path  = "/health",
    allow_cidr_blocks = [],
  }

  description = "Internal ingress configuration for the deployed application (for in-VPC/peering connections)."
}

variable "oidc_ingress" {
  type = object({
    enabled            = bool,
    fqdn               = string,
    certificate_arns   = list(string),
    healthcheck_path   = string,
    issuer             = string,
    authorize_endpoint = string,
    token_endpoint     = string,
    userinfo_endpoint  = string,
    allow_cidr_blocks  = list(string),
  })

  default = {
    enabled            = false,
    fqdn               = "",
    certificate_arns   = [],
    healthcheck_path   = "/health",
    issuer             = "",
    authorize_endpoint = "",
    token_endpoint     = "",
    userinfo_endpoint  = "",
    allow_cidr_blocks  = [],
  }

  description = "Ingress configuration for OIDC authentication."
}

variable "basic_auth_ingress" {
  type = object({
    enabled           = bool,
    fqdn              = string,
    certificate_arns  = list(string),
    healthcheck_path  = string,
    allow_cidr_blocks = list(string),
  })

  default = {
    enabled           = false,
    fqdn              = "",
    certificate_arns  = [],
    healthcheck_path  = "/health",
    allow_cidr_blocks = [],
  }

  description = "Ingress configuration for the Basic Auth load balancer."
}

variable "passthrough_ingress" {
  type = object({
    enabled           = bool,
    internal          = bool,
    fqdn              = string,
    port              = number,
    allow_cidr_blocks = list(string),
  })

  default = {
    enabled           = false,
    internal          = true,
    fqdn              = "",
    port              = 443,
    allow_cidr_blocks = [],
  }

  description = "Configuration for the optional \"passthrough\" ingress."
}

variable "ssm_secrets_path" {
  type = string

  default     = ""
  description = "Default path at AWS SSM to lookup secret parameters within (assigned automatically if empty)."
}

variable "cluster_rbac_rules" {
  type = map(object({
    api_groups = list(string),
    resources  = list(string),
    verbs      = list(string),
  }))

  default     = {}
  description = "Cluster-wide RBAC permissions for the deployment's service account."
}

variable "pod_security_context" {
  type = object({
    fs_group = number,
  })

  default = {
    fs_group = 65534,
  }

  description = "Pod security context settings."
}

variable "container_security_context" {
  type = object({
    add_capabilities  = list(string),
    drop_capabilities = list(string),
  })

  default = {
    add_capabilities  = [],
    drop_capabilities = [],
  }

  description = "Container-level security context settings."
}

variable "files_mount_path" {
  type = string

  default     = "/files.d"
  description = "Mount path for \"files\" configMap-based volume."
}

variable "files" {
  type = map(string)

  default     = {}
  description = "A map of <file_name>:<file_content> form used to populate \"files\" configMap-based volume."
}

variable "binary_files" {
  type = map(string)

  default     = {}
  description = "A map of <file_name>:<file_content> form used to populate \"files\" configMap-based volume."
}

variable "default_mode_secrets" {
  type = string

  default     = "0400"
  description = "Default file access mode for mounted secrets."
}

variable "enable_dind" {
  type = bool

  default     = false
  description = "Enable Docker-in-Docker sidecar (useful for CI systems)"
}

variable "enable_redis" {
  type = bool

  default     = false
  description = "Enable Redis sidecar (useful for small all-in-one systems)"
}

variable "enable_statsd_exporter" {
  type = bool

  default     = false
  description = "Enable statsd-exporter sidecar"
}

variable "run_as_non_root" {
  type        = bool
  default     = false
  description = "Needs to be true in order to run the container as a non-root user"
}

variable "run_as_group" {
  type        = string
  default     = "0"
  description = "Defines the group where the container will run, default 0"
}

variable "run_as_user" {
  type        = string
  default     = "0"
  description = "defines the user id that will run the container, default 0 (root)"
}

variable "shm_mem_enabled" {
  type        = string
  default     = ""
  description = "Enable shm mem mount to use it on a container"
}

variable "shm_mem" {
  type        = string
  default     = "64Mi"
  description = "shm memory Mi"
}

variable "shared_volume_path" {
  type        = string
  default     = "/shared"
  description = "Path on which shared intra-pod volume will be mounted inside containers"
}

variable "extra_policy_statements" {
  type = list(object({
    effect    = string,
    actions   = list(string),
    resources = list(string),
  }))

  default     = []
  description = "List of extra policies required by the App or Service"
}

variable "load_balancer_attributes" {
  type = map(string)

  default     = {}
  description = "A <key>:<value> map of AWS load balancer attributes"
}

variable "tags" {
  description = "Tags to identify resources ownership"
  type = object({
    team    = string
    impact  = string
    service = string
  })
}

variable "enable_multi_az_deployment" {
  type        = bool
  description = "Enable multi-az deployment, i.e., applies an anti affinity rule to spread pods across availability zones."
  default     = false
}

variable "public_subnet_tags" {
  type        = map(string)
  description = "Discover public subnets by these tags (for ingress/ALB), keep null to discover automatically."
  default     = null
}

variable "private_subnet_tags" {
  type        = map(string)
  description = "Discover private subnets by these tags (for ingress/ALB), keep null to discover automatically."
  default     = null
}

variable "custom_volumes" {
  type = list(object({
    name       = string,
    claim_name = string,
    mount_path = string,
  }))
  description = "Custom volumes to be mounted in the container"
  default     = []
}

variable "aws_region" {
  type        = string
  default     = ""
  description = "AWS region name to use on the name of the IAM role"
}

variable "arch_selection" {
  type        = bool
  default     = true
  description = "Whether to enable architecture node selection. This should always be on unless you want to target specific nodes like NVMe nodes via other tolerations."
}

variable "deploy_arch" {
  type    = string
  default = "arm64"

  description = "Use \"arm64\" or \"amd64\" nodes for deployment."

  validation {
    condition     = contains(["amd64", "arm64"], var.deploy_arch)
    error_message = "Can be either \"amd64\" or \"arm64\"."
  }
}

variable "create_iam_role" {
  type    = bool
  default = true

  description = "Whether to create an IAM role for the deployment."
}

variable "iam_role_name" {
  type    = string
  default = ""

  description = "Use this name for the IAM role instead of trusting module to autoname it."
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

variable "deployment_strategy" {
  type        = string
  default     = "RollingUpdate"
  description = "Deployment strategy to use for k8s deployments"
  validation {
    condition = contains(
      ["RollingUpdate", "Recreate"],
      var.deployment_strategy
    )
    error_message = "Deployment strategy must be either RollingUpdate or Recreate."
  }
}

variable "disruption_setting" {
  type = object({
    min_available   = optional(string),
    max_unavailable = optional(string),
  })
  default = {
    min_available = 1
  }

  description = "Limits of deployment pods that are down simultaneously from voluntary disruptions."
}

variable "disable_disruption" {
  type    = bool
  default = false

  description = "Set to true to block Karpenter from voluntarily choosing to disrupt certain pods."
}

variable "create_service" {
  type    = bool
  default = true

  description = "Whether to create a Kubernetes service for the deployment"
}

variable "add_cluster_label" {
  type    = bool
  default = true

  description = "Whether to add the EKS cluster name as a label. Can be disabled for backwards compatibility (avoids recreating the deployment)."
}

variable "cron_jobs" {
  type = map(object({
    schedule                   = string
    image                      = optional(string)
    command                    = optional(list(string), [])
    args                       = optional(list(string), [])
    restart_policy             = optional(string, "Never")
    backoff_limit              = optional(number, 3)
    ttl_seconds_after_finished = optional(number, 3600)
  }))
  default = {}

  description = "CronJobs to create, name => settings."
}
