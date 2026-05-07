# simple-deployment

This module configures a general purpose deployment on a kubernetes cluster.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | ~> 2 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.extra_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.extra_policy_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.basic_auth_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.internal_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.oidc_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_http_oidc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_https_basic_auth](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_https_oidc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.internal_allow_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.internal_allow_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [kubernetes_cluster_role.app](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role_binding.app](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_config_map.files](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_cron_job_v1.cronjob](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cron_job_v1) | resource |
| [kubernetes_deployment.app](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [kubernetes_ingress_v1.app](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource |
| [kubernetes_ingress_v1.basic_auth](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource |
| [kubernetes_ingress_v1.internal](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource |
| [kubernetes_ingress_v1.oidc](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource |
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_pod_disruption_budget_v1.app](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod_disruption_budget_v1) | resource |
| [kubernetes_role.oidc_ingress](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role) | resource |
| [kubernetes_role_binding.oidc_ingress](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_secret.oidc](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.ssm](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_service.app](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |
| [kubernetes_service.passthrough_ingress](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |
| [kubernetes_service_account.app](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [random_password.basic_auth_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.basic_auth_user](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_iam_policy_document.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.extra_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_ssm_parameter.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.oidc_client_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.oidc_client_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_subnets.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_subnets.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_add_cluster_label"></a> [add\_cluster\_label](#input\_add\_cluster\_label) | Whether to add the EKS cluster name as a label. Can be disabled for backwards compatibility (avoids recreating the deployment). | `bool` | `true` | no |
| <a name="input_app_image_repo"></a> [app\_image\_repo](#input\_app\_image\_repo) | Docker repository to pull application image from. | `string` | n/a | yes |
| <a name="input_app_image_tag"></a> [app\_image\_tag](#input\_app\_image\_tag) | Tag of the application Docker image (tag = application version). | `string` | n/a | yes |
| <a name="input_arch_selection"></a> [arch\_selection](#input\_arch\_selection) | Whether to enable architecture node selection. This should always be on unless you want to target specific nodes like NVMe nodes via other tolerations. | `bool` | `true` | no |
| <a name="input_args"></a> [args](#input\_args) | Pass arguments to application container's command (if you need it). | `list(string)` | `[]` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region name to use on the name of the IAM role | `string` | `""` | no |
| <a name="input_backend_https"></a> [backend\_https](#input\_backend\_https) | Does in-cluster service uses HTTPS? (by default it should use HTTP) | `bool` | `false` | no |
| <a name="input_backend_port"></a> [backend\_port](#input\_backend\_port) | Application internal [non-ingress] port to communicate inside cluster. | `number` | `80` | no |
| <a name="input_basic_auth_ingress"></a> [basic\_auth\_ingress](#input\_basic\_auth\_ingress) | Ingress configuration for the Basic Auth load balancer. | <pre>object({<br>    enabled           = bool,<br>    fqdn              = string,<br>    certificate_arns  = list(string),<br>    healthcheck_path  = string,<br>    allow_cidr_blocks = list(string),<br>  })</pre> | <pre>{<br>  "allow_cidr_blocks": [],<br>  "certificate_arns": [],<br>  "enabled": false,<br>  "fqdn": "",<br>  "healthcheck_path": "/health"<br>}</pre> | no |
| <a name="input_binary_files"></a> [binary\_files](#input\_binary\_files) | A map of <file\_name>:<file\_content> form used to populate "files" configMap-based volume. | `map(string)` | `{}` | no |
| <a name="input_cluster_rbac_rules"></a> [cluster\_rbac\_rules](#input\_cluster\_rbac\_rules) | Cluster-wide RBAC permissions for the deployment's service account. | <pre>map(object({<br>    api_groups = list(string),<br>    resources  = list(string),<br>    verbs      = list(string),<br>  }))</pre> | `{}` | no |
| <a name="input_command"></a> [command](#input\_command) | Run application container with this command or leave empty to run container's own command. | `list(string)` | `[]` | no |
| <a name="input_container_security_context"></a> [container\_security\_context](#input\_container\_security\_context) | Container-level security context settings. | <pre>object({<br>    add_capabilities  = list(string),<br>    drop_capabilities = list(string),<br>  })</pre> | <pre>{<br>  "add_capabilities": [],<br>  "drop_capabilities": []<br>}</pre> | no |
| <a name="input_create_iam_role"></a> [create\_iam\_role](#input\_create\_iam\_role) | Whether to create an IAM role for the deployment. | `bool` | `true` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Whether to create the namespace. | `bool` | `false` | no |
| <a name="input_create_service"></a> [create\_service](#input\_create\_service) | Whether to create a Kubernetes service for the deployment | `bool` | `true` | no |
| <a name="input_cron_jobs"></a> [cron\_jobs](#input\_cron\_jobs) | CronJobs to create, name => settings. | <pre>map(object({<br>    schedule                   = string<br>    image                      = optional(string)<br>    command                    = optional(list(string), [])<br>    args                       = optional(list(string), [])<br>    restart_policy             = optional(string, "Never")<br>    backoff_limit              = optional(number, 3)<br>    ttl_seconds_after_finished = optional(number, 3600)<br>  }))</pre> | `{}` | no |
| <a name="input_custom_volumes"></a> [custom\_volumes](#input\_custom\_volumes) | Custom volumes to be mounted in the container | <pre>list(object({<br>    name       = string,<br>    claim_name = string,<br>    mount_path = string,<br>  }))</pre> | `[]` | no |
| <a name="input_default_mode_secrets"></a> [default\_mode\_secrets](#input\_default\_mode\_secrets) | Default file access mode for mounted secrets. | `string` | `"0400"` | no |
| <a name="input_deploy_arch"></a> [deploy\_arch](#input\_deploy\_arch) | Use "arm64" or "amd64" nodes for deployment. | `string` | `"arm64"` | no |
| <a name="input_deployment_strategy"></a> [deployment\_strategy](#input\_deployment\_strategy) | Deployment strategy to use for k8s deployments | `string` | `"RollingUpdate"` | no |
| <a name="input_dind_limits"></a> [dind\_limits](#input\_dind\_limits) | Maximum cluster resource usage for a single application container. | `object({ cpu = string, memory = string, ephemeral-storage = string })` | <pre>{<br>  "cpu": "1",<br>  "ephemeral-storage": "4Gi",<br>  "memory": "1024Mi"<br>}</pre> | no |
| <a name="input_dind_requests"></a> [dind\_requests](#input\_dind\_requests) | Resources to be requested from Kubernetes cluster for each application container running. | `object({ cpu = string, memory = string, ephemeral-storage = string })` | <pre>{<br>  "cpu": "0.5",<br>  "ephemeral-storage": "2Gi",<br>  "memory": "512Mi"<br>}</pre> | no |
| <a name="input_disable_disruption"></a> [disable\_disruption](#input\_disable\_disruption) | Set to true to block Karpenter from voluntarily choosing to disrupt certain pods. | `bool` | `false` | no |
| <a name="input_disruption_setting"></a> [disruption\_setting](#input\_disruption\_setting) | Limits of deployment pods that are down simultaneously from voluntary disruptions. | <pre>object({<br>    min_available   = optional(string),<br>    max_unavailable = optional(string),<br>  })</pre> | <pre>{<br>  "min_available": 1<br>}</pre> | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Name of the EKS cluster we deploy application into. | `string` | n/a | yes |
| <a name="input_enable_dind"></a> [enable\_dind](#input\_enable\_dind) | Enable Docker-in-Docker sidecar (useful for CI systems) | `bool` | `false` | no |
| <a name="input_enable_multi_az_deployment"></a> [enable\_multi\_az\_deployment](#input\_enable\_multi\_az\_deployment) | Enable multi-az deployment, i.e., applies an anti affinity rule to spread pods across availability zones. | `bool` | `false` | no |
| <a name="input_enable_redis"></a> [enable\_redis](#input\_enable\_redis) | Enable Redis sidecar (useful for small all-in-one systems) | `bool` | `false` | no |
| <a name="input_enable_statsd_exporter"></a> [enable\_statsd\_exporter](#input\_enable\_statsd\_exporter) | Enable statsd-exporter sidecar | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | Populate container environment variables with map of <env var name>:<env var value> key/value pairs. | `map(string)` | `{}` | no |
| <a name="input_env_from_field_ref"></a> [env\_from\_field\_ref](#input\_env\_from\_field\_ref) | Populate container environment variables with map of <env var name>:{api\_version: <api\_version>, field\_path: <field\_pathm>}}. | <pre>map(object({<br>    api_version = string,<br>    field_path  = string,<br>  }))</pre> | `{}` | no |
| <a name="input_env_from_ssm_secrets"></a> [env\_from\_ssm\_secrets](#input\_env\_from\_ssm\_secrets) | Populate container environment variables with the secrets loaded from SSM (set absolute SSM parameter path to override "ssm\_secrets\_path" prefix). | `list(string)` | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Application environment, e.g. "tfprod" or "dev", or "tools". | `string` | n/a | yes |
| <a name="input_extra_policy_statements"></a> [extra\_policy\_statements](#input\_extra\_policy\_statements) | List of extra policies required by the App or Service | <pre>list(object({<br>    effect    = string,<br>    actions   = list(string),<br>    resources = list(string),<br>  }))</pre> | `[]` | no |
| <a name="input_files"></a> [files](#input\_files) | A map of <file\_name>:<file\_content> form used to populate "files" configMap-based volume. | `map(string)` | `{}` | no |
| <a name="input_files_mount_path"></a> [files\_mount\_path](#input\_files\_mount\_path) | Mount path for "files" configMap-based volume. | `string` | `"/files.d"` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | Use this name for the IAM role instead of trusting module to autoname it. | `string` | `""` | no |
| <a name="input_image_pull_policy"></a> [image\_pull\_policy](#input\_image\_pull\_policy) | When to pull app Docker image? Set to "IfNotPresent", "Always" or "Never". | `string` | `"IfNotPresent"` | no |
| <a name="input_image_pull_secrets"></a> [image\_pull\_secrets](#input\_image\_pull\_secrets) | A list of Docker registry access secrets to use for pulling application images. | `list(string)` | <pre>[<br>  "common-image-pull"<br>]</pre> | no |
| <a name="input_ingress"></a> [ingress](#input\_ingress) | Ingress configuration for the deployed application. | <pre>object({<br>    enabled           = bool,<br>    fqdn              = string,<br>    certificate_arns  = list(string),<br>    healthcheck_path  = string,<br>    allow_cidr_blocks = list(string),<br>  })</pre> | <pre>{<br>  "allow_cidr_blocks": [],<br>  "certificate_arns": [],<br>  "enabled": false,<br>  "fqdn": "",<br>  "healthcheck_path": "/health"<br>}</pre> | no |
| <a name="input_internal_ingress"></a> [internal\_ingress](#input\_internal\_ingress) | Internal ingress configuration for the deployed application (for in-VPC/peering connections). | <pre>object({<br>    enabled           = bool,<br>    fqdn              = string,<br>    certificate_arns  = list(string),<br>    healthcheck_path  = string,<br>    allow_cidr_blocks = list(string),<br>  })</pre> | <pre>{<br>  "allow_cidr_blocks": [],<br>  "certificate_arns": [],<br>  "enabled": false,<br>  "fqdn": "",<br>  "healthcheck_path": "/health"<br>}</pre> | no |
| <a name="input_limits"></a> [limits](#input\_limits) | Maximum cluster resource usage for a single application container. | `object({ cpu = string, memory = string, ephemeral-storage = string })` | <pre>{<br>  "cpu": "1",<br>  "ephemeral-storage": "4Gi",<br>  "memory": "1024Mi"<br>}</pre> | no |
| <a name="input_liveness_probes"></a> [liveness\_probes](#input\_liveness\_probes) | HTTP probes to determine if container is alive. | <pre>map(<br>    object({<br>      port = number,<br>      path = string,<br>      tls  = bool,<br>  }))</pre> | `{}` | no |
| <a name="input_load_balancer_attributes"></a> [load\_balancer\_attributes](#input\_load\_balancer\_attributes) | A <key>:<value> map of AWS load balancer attributes | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the application (Kubernetes deployment/service/serviceaccount will be named accordingly). | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace to deploy into. | `string` | n/a | yes |
| <a name="input_oidc_ingress"></a> [oidc\_ingress](#input\_oidc\_ingress) | Ingress configuration for OIDC authentication. | <pre>object({<br>    enabled            = bool,<br>    fqdn               = string,<br>    certificate_arns   = list(string),<br>    healthcheck_path   = string,<br>    issuer             = string,<br>    authorize_endpoint = string,<br>    token_endpoint     = string,<br>    userinfo_endpoint  = string,<br>    allow_cidr_blocks  = list(string),<br>  })</pre> | <pre>{<br>  "allow_cidr_blocks": [],<br>  "authorize_endpoint": "",<br>  "certificate_arns": [],<br>  "enabled": false,<br>  "fqdn": "",<br>  "healthcheck_path": "/health",<br>  "issuer": "",<br>  "token_endpoint": "",<br>  "userinfo_endpoint": ""<br>}</pre> | no |
| <a name="input_passthrough_ingress"></a> [passthrough\_ingress](#input\_passthrough\_ingress) | Configuration for the optional "passthrough" ingress. | <pre>object({<br>    enabled           = bool,<br>    internal          = bool,<br>    fqdn              = string,<br>    port              = number,<br>    allow_cidr_blocks = list(string),<br>  })</pre> | <pre>{<br>  "allow_cidr_blocks": [],<br>  "enabled": false,<br>  "fqdn": "",<br>  "internal": true,<br>  "port": 443<br>}</pre> | no |
| <a name="input_pod_security_context"></a> [pod\_security\_context](#input\_pod\_security\_context) | Pod security context settings. | <pre>object({<br>    fs_group = number,<br>  })</pre> | <pre>{<br>  "fs_group": 65534<br>}</pre> | no |
| <a name="input_private_subnet_tags"></a> [private\_subnet\_tags](#input\_private\_subnet\_tags) | Discover private subnets by these tags (for ingress/ALB), keep null to discover automatically. | `map(string)` | `null` | no |
| <a name="input_public_subnet_tags"></a> [public\_subnet\_tags](#input\_public\_subnet\_tags) | Discover public subnets by these tags (for ingress/ALB), keep null to discover automatically. | `map(string)` | `null` | no |
| <a name="input_readiness_probes"></a> [readiness\_probes](#input\_readiness\_probes) | HTTP probes to determine if container is ready to serve traffic. | <pre>map(<br>    object({<br>      port = number,<br>      path = string,<br>      tls  = bool,<br>  }))</pre> | `{}` | no |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | Number of replicas for the application Kubernetes deployment. | `number` | `1` | no |
| <a name="input_requests"></a> [requests](#input\_requests) | Resources to be requested from Kubernetes cluster for each application container running. | `object({ cpu = string, memory = string, ephemeral-storage = string })` | <pre>{<br>  "cpu": "0.5",<br>  "ephemeral-storage": "2Gi",<br>  "memory": "512Mi"<br>}</pre> | no |
| <a name="input_run_as_group"></a> [run\_as\_group](#input\_run\_as\_group) | Defines the group where the container will run, default 0 | `string` | `"0"` | no |
| <a name="input_run_as_non_root"></a> [run\_as\_non\_root](#input\_run\_as\_non\_root) | Needs to be true in order to run the container as a non-root user | `bool` | `false` | no |
| <a name="input_run_as_user"></a> [run\_as\_user](#input\_run\_as\_user) | defines the user id that will run the container, default 0 (root) | `string` | `"0"` | no |
| <a name="input_shared_volume_path"></a> [shared\_volume\_path](#input\_shared\_volume\_path) | Path on which shared intra-pod volume will be mounted inside containers | `string` | `"/shared"` | no |
| <a name="input_shm_mem"></a> [shm\_mem](#input\_shm\_mem) | shm memory Mi | `string` | `"64Mi"` | no |
| <a name="input_shm_mem_enabled"></a> [shm\_mem\_enabled](#input\_shm\_mem\_enabled) | Enable shm mem mount to use it on a container | `string` | `""` | no |
| <a name="input_ssm_secrets_path"></a> [ssm\_secrets\_path](#input\_ssm\_secrets\_path) | Default path at AWS SSM to lookup secret parameters within (assigned automatically if empty). | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to identify resources ownership | <pre>object({<br>    team    = string<br>    impact  = string<br>    service = string<br>  })</pre> | n/a | yes |
| <a name="input_tolerations"></a> [tolerations](#input\_tolerations) | Pod tolerations. | <pre>list(object({<br>    key      = optional(string)<br>    operator = optional(string)<br>    value    = optional(string)<br>    effect   = optional(string)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_basic_auth_password"></a> [basic\_auth\_password](#output\_basic\_auth\_password) | Basic authentication password, if enabled. |
| <a name="output_basic_auth_token"></a> [basic\_auth\_token](#output\_basic\_auth\_token) | Basic authentication token (base64 encoded 'username:password'), if enabled. |
| <a name="output_basic_auth_username"></a> [basic\_auth\_username](#output\_basic\_auth\_username) | Basic authentication username, if enabled. |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | ARN of the role assumed by containers. |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | Name of the role assumed by containers. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
