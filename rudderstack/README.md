# rudderstack-dep

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.16.1 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.13.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.16.1 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.13.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.rudderstack](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.rudderstack_virtual_service](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_version"></a> [app\_version](#input\_app\_version) | Application version AKA container image tag | `string` | n/a | yes |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Version of "tf-http-server" chart to install | `string` | n/a | yes |
| <a name="input_config"></a> [config](#input\_config) | DEP application configuration set as environment variables | <pre>object({<br>    consumer_group_id         = string<br>    destination_topic         = string<br>    internal_queue_topic      = string<br>    kafka_brokers             = list(string)<br>    kafka_brokers_tls         = bool<br>    kafka_consumer_group_name = string<br>    port                      = number<br>  })</pre> | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Application deploy environment | `string` | n/a | yes |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Public access FQDN for Rudderstack dispatcher | `string` | n/a | yes |
| <a name="input_image_repository"></a> [image\_repository](#input\_image\_repository) | Container image repository to pull images from | `string` | `"567716553783.dkr.ecr.us-east-1.amazonaws.com/data-rudderstackdep"` | no |
| <a name="input_internal_root_domain"></a> [internal\_root\_domain](#input\_internal\_root\_domain) | Root domain for internal access | `string` | n/a | yes |
| <a name="input_istio_gateway"></a> [istio\_gateway](#input\_istio\_gateway) | Name of the upstream Istio gateway in form of <namespace>/<gateway> | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | A Kubernetes namespace to deploy into | `string` | n/a | yes |
| <a name="input_resources"></a> [resources](#input\_resources) | Kubernetes resource constraints | <pre>object({<br>    cpu_requests    = string<br>    memory_requests = string<br>    memory_limits   = string<br>  })</pre> | n/a | yes |
| <a name="input_scale"></a> [scale](#input\_scale) | Kubernetes HPA config | <pre>object({<br>    min_replicas = number<br>    max_replicas = number<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
