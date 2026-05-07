# caddy

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.21.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.21.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_config_map.caddy](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_deployment.caddy](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [kubernetes_pod_disruption_budget_v1.caddy](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod_disruption_budget_v1) | resource |
| [kubernetes_service.caddy](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |
| [kubernetes_service_account.caddy](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alias_domain"></a> [alias\_domain](#input\_alias\_domain) | Alias domain that custom domains have their CNAME set to (e.g. 'alias.videoask.com'). | `string` | n/a | yes |
| <a name="input_allowed_cidrs"></a> [allowed\_cidrs](#input\_allowed\_cidrs) | List of allowed CIDR ranges. | `list(string)` | `[]` | no |
| <a name="input_certificates_email"></a> [certificates\_email](#input\_certificates\_email) | Email used for certificate generation. | `string` | `"ops+caddy@powise.com"` | no |
| <a name="input_confirmation_endpoint_url"></a> [confirmation\_endpoint\_url](#input\_confirmation\_endpoint\_url) | Endpoint URL to confirm which domains can have their certificate generated. | `string` | n/a | yes |
| <a name="input_deploy_arch"></a> [deploy\_arch](#input\_deploy\_arch) | Node architecture to deploy to. Must be either "amd64" or "arm64" | `string` | `"arm64"` | no |
| <a name="input_disable_http_challenge"></a> [disable\_http\_challenge](#input\_disable\_http\_challenge) | Whether to disable the HTTP challenge for certificate generation. | `bool` | `false` | no |
| <a name="input_disable_tls_alpn_challenge"></a> [disable\_tls\_alpn\_challenge](#input\_disable\_tls\_alpn\_challenge) | Whether to disable the TLS-ALPN challenge for certificate generation. | `bool` | `false` | no |
| <a name="input_docker_image_repository"></a> [docker\_image\_repository](#input\_docker\_image\_repository) | Docker image repository. | `string` | `"567716553783.dkr.ecr.us-east-1.amazonaws.com/caddy"` | no |
| <a name="input_docker_image_tag"></a> [docker\_image\_tag](#input\_docker\_image\_tag) | Docker image tag. | `string` | `"latest"` | no |
| <a name="input_dynamodb_table_name"></a> [dynamodb\_table\_name](#input\_dynamodb\_table\_name) | DynamoDB table name to store certificates. | `string` | n/a | yes |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | Caddy log level, see https://caddyserver.com/docs/json/logging/logs/level/ for acceptable values. | `string` | `"DEBUG"` | no |
| <a name="input_name"></a> [name](#input\_name) | Caddy installation name. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace to install Caddy. | `string` | n/a | yes |
| <a name="input_proxied_host"></a> [proxied\_host](#input\_proxied\_host) | Service host behind the Caddy reverse proxy. | `string` | n/a | yes |
| <a name="input_proxied_port"></a> [proxied\_port](#input\_proxied\_port) | Port of the service being proxied. | `number` | n/a | yes |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | Number of replicas. | `number` | `2` | no |
| <a name="input_resources_limits"></a> [resources\_limits](#input\_resources\_limits) | Pod resources limits, in Kubernetes format. | <pre>object({<br>    cpu    = optional(string, "1000m"),<br>    memory = optional(string, "1024Mi"),<br>  })</pre> | `{}` | no |
| <a name="input_resources_requests"></a> [resources\_requests](#input\_resources\_requests) | Pod resources requests, in Kubernetes format. | <pre>object({<br>    cpu    = optional(string, "250m"),<br>    memory = optional(string, "256Mi"),<br>  })</pre> | `{}` | no |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | Role to be assumed by Caddy to reach the DynamoDB table. | `string` | n/a | yes |
| <a name="input_tolerations"></a> [tolerations](#input\_tolerations) | Pod tolerations. | <pre>list(object({<br>    key      = optional(string)<br>    operator = optional(string)<br>    value    = optional(string)<br>    effect   = optional(string)<br>  }))</pre> | `[]` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
