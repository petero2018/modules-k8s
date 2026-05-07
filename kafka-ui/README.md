# kafka-ui

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.6 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.16.1 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.19.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.16.1 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.19.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.kafka_ui](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.virtual_service](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bootstrap_servers"></a> [bootstrap\_servers](#input\_bootstrap\_servers) | Kafka broker connection strings | `string` | n/a | yes |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Version of the Kafka UI Helm chart | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the Kafka cluster | `string` | n/a | yes |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Hostname for accessing the Kafka UI | `string` | n/a | yes |
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | ARN of the IAM role to assume inside the pod | `string` | n/a | yes |
| <a name="input_istio_gateway"></a> [istio\_gateway](#input\_istio\_gateway) | Name of the upstream Istio gateway in form of <namespace>/<gateway> | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | A Kubernetes namespace to deploy into | `string` | n/a | yes |
| <a name="input_resources"></a> [resources](#input\_resources) | Resource configuration for Kafka UI pods | <pre>object({<br>    cpu_requests    = string<br>    memory_requests = string<br>    memory_limits   = string<br>  })</pre> | <pre>{<br>  "cpu_requests": "500m",<br>  "memory_limits": "1Gi",<br>  "memory_requests": "500Mi"<br>}</pre> | no |
| <a name="input_scale"></a> [scale](#input\_scale) | Scaling configuration for Kafka UI | <pre>object({<br>    min_replicas = number<br>    max_replicas = number<br>  })</pre> | <pre>{<br>  "max_replicas": 10,<br>  "min_replicas": 1<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
