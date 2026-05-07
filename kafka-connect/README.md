# rudderstack-dep

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.6 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | <3 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.19.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | <3 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.19.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.kafka_connect](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.virtual_service](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_config"></a> [app\_config](#input\_app\_config) | Application configuration set as environment variables | <pre>object({<br>    bootstrap_servers        = string<br>    group_id                 = optional(string, "kafka-connect")<br>    replication_factor       = optional(number, 3)<br>    config_storage_topic     = optional(string, "kafka-connect-configs")<br>    offset_storage_topic     = optional(string, "kafka-connect-offsets")<br>    offset_flush_interval_ms = optional(number, 10000)<br>    status_storage_topic     = optional(string, "kafka-connect-status")<br>    api_port                 = optional(number, 8083)<br>  })</pre> | n/a | yes |
| <a name="input_app_version"></a> [app\_version](#input\_app\_version) | Application version AKA container image tag | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy into | `string` | n/a | yes |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Version of "tf-http-server" chart to install | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Application deploy environment | `string` | n/a | yes |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Access FQDN | `string` | n/a | yes |
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | ARN of the IAM role to assume inside the pod | `string` | n/a | yes |
| <a name="input_image_repository"></a> [image\_repository](#input\_image\_repository) | Container image repository to pull images from | `string` | `"567716553783.dkr.ecr.us-east-1.amazonaws.com/powise-kafka-connect"` | no |
| <a name="input_istio_gateway"></a> [istio\_gateway](#input\_istio\_gateway) | Name of the upstream Istio gateway in form of <namespace>/<gateway> | `string` | n/a | yes |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | Log level for Kafka Connect | `string` | `"WARN"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | A Kubernetes namespace to deploy into | `string` | n/a | yes |
| <a name="input_resources"></a> [resources](#input\_resources) | Kubernetes resource constraints | <pre>object({<br>    cpu_requests    = string<br>    memory_requests = string<br>    memory_limits   = string<br>  })</pre> | <pre>{<br>  "cpu_requests": "1",<br>  "memory_limits": "6Gi",<br>  "memory_requests": "4Gi"<br>}</pre> | no |
| <a name="input_scale"></a> [scale](#input\_scale) | Kubernetes HPA config | <pre>object({<br>    min_replicas = number<br>    max_replicas = number<br>  })</pre> | <pre>{<br>  "max_replicas": 10,<br>  "min_replicas": 3<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
