# Datadog Agent

Install [Data Dog](https://www.datadoghq.com/) Agent helm chart.

Setting `use_custom_image` to `true` will use a custom image maintained by powise. Currently this custom image supports the following integrations:

* [Gatekeeper][gatekeeper_integration]

To build a new version of this image, use this [repository][dd_repo] and this [dd_job][dd_job].

[gatekeeper_integration]: https://docs.datadoghq.com/integrations/gatekeeper/
[dd_repo]: https://github.com/powise/powise-stack/tree/master/docker/datadog-agent
[dd_job]: https://jenkins.tools.powise.tf/job/utilities/job/build-docker-image/

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.68.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.68.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_agent_role"></a> [agent\_role](#module\_agent\_role) | ../../eks/irsa | n/a |
| <a name="module_datadog"></a> [datadog](#module\_datadog) | ../helm-release | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.opensearch_read_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_iam_policy_arns"></a> [agent\_iam\_policy\_arns](#input\_agent\_iam\_policy\_arns) | List of IAM policy ARNs to attach to the agent role. | `list(string)` | `[]` | no |
| <a name="input_agent_tolerations"></a> [agent\_tolerations](#input\_agent\_tolerations) | Allow the Cluster Agent Deployment to schedule on tainted nodes. | <pre>list(object({<br>    key      = optional(string)<br>    operator = string<br>    effect   = optional(string)<br>  }))</pre> | <pre>[<br>  {<br>    "operator": "Exists"<br>  }<br>]</pre> | no |
| <a name="input_argocd_app_config"></a> [argocd\_app\_config](#input\_argocd\_app\_config) | ArgoCD Application config. See k8s/argocd/resources/application | `any` | `{}` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | The version of External Secrets Operator to install. | `string` | n/a | yes |
| <a name="input_clickhouse_clusters"></a> [clickhouse\_clusters](#input\_clickhouse\_clusters) | List of ClickHouse clusters to monitor. | <pre>list(object({<br>    name          = string<br>    replica_hosts = list(string)<br>    port          = optional(number, 9440)<br>    username      = string<br>    password      = string<br>  }))</pre> | n/a | yes |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if it does not yet exist. | `bool` | `true` | no |
| <a name="input_custom_tags"></a> [custom\_tags](#input\_custom\_tags) | Custom tags to add to the metrics | `list(string)` | `[]` | no |
| <a name="input_datadog_api_key"></a> [datadog\_api\_key](#input\_datadog\_api\_key) | Datadog API key. | `string` | `null` | no |
| <a name="input_datadog_app_key"></a> [datadog\_app\_key](#input\_datadog\_app\_key) | Datadog application key. | `string` | `null` | no |
| <a name="input_datadog_checks_cardinality"></a> [datadog\_checks\_cardinality](#input\_datadog\_checks\_cardinality) | Add tags to check metrics (low, orchestrator, high). More info here: https://docs.datadoghq.com/getting_started/tagging/assigning_tags/?tab=containerizedenvironments#environment-variables | `string` | `"low"` | no |
| <a name="input_datadog_site"></a> [datadog\_site](#input\_datadog\_site) | Datadog site (i.e. region) domain where to send the data. | `string` | `"datadoghq.com"` | no |
| <a name="input_dd_external_metrics_provider_max_age"></a> [dd\_external\_metrics\_provider\_max\_age](#input\_dd\_external\_metrics\_provider\_max\_age) | DD\_EXTERNAL\_METRICS\_PROVIDER\_MAX\_AGE environment variable. Maximum age (in seconds) of a datapoint before considering it invalid to be served. Default to 120 seconds. | `string` | `"120"` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Unique cluster name to allow scoping hosts and Cluster Checks easily. | `string` | n/a | yes |
| <a name="input_enable_apm"></a> [enable\_apm](#input\_enable\_apm) | Enables APM Agent. | `bool` | `false` | no |
| <a name="input_enable_logs"></a> [enable\_logs](#input\_enable\_logs) | Enables Logs Agent. And collect all the logs. | `bool` | `false` | no |
| <a name="input_enable_process_agent"></a> [enable\_process\_agent](#input\_enable\_process\_agent) | Enables Process Agent. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name to group all the metrics in an environment tag. | `string` | `null` | no |
| <a name="input_helm_config"></a> [helm\_config](#input\_helm\_config) | Helm provider config for External Secrets Operator | `any` | `{}` | no |
| <a name="input_kube_status"></a> [kube\_status](#input\_kube\_status) | Define it if you want to get metrics grouped in a `kube_status` tag. | `string` | `null` | no |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | Set logging verbosity, valid log levels are: trace, debug, info, warn, error, critical, off | `string` | `"WARN"` | no |
| <a name="input_manage_via_argocd"></a> [manage\_via\_argocd](#input\_manage\_via\_argocd) | Determines if the release should be managed via ArgoCD. | `bool` | `false` | no |
| <a name="input_msk_cluster_arns"></a> [msk\_cluster\_arns](#input\_msk\_cluster\_arns) | List of AWS MSK Cluster ARNs used for Kafka Metrics. | `list(string)` | `[]` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to install the components in. | `string` | `"datadog"` | no |
| <a name="input_opensearch_arns"></a> [opensearch\_arns](#input\_opensearch\_arns) | List of OpenSearch ARNs to allow the Datadog agent to monitor. | `list(string)` | `[]` | no |
| <a name="input_opensearch_urls"></a> [opensearch\_urls](#input\_opensearch\_urls) | List of OpenSearch URLs to monitor. | <pre>list(object({<br>    url       = string<br>    auth_type = optional(string)<br>    region    = optional(string, null)<br>  }))</pre> | `[]` | no |
| <a name="input_pod_labels_as_tags"></a> [pod\_labels\_as\_tags](#input\_pod\_labels\_as\_tags) | Maps pod labels as datadog tags. | `map(string)` | <pre>{<br>  "impact": "impact",<br>  "is-ephemeral": "kube_is_ephemeral",<br>  "service": "app",<br>  "team": "team"<br>}</pre> | no |
| <a name="input_product"></a> [product](#input\_product) | Define it if you want to get metrics grouped in a `product` tag. | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | Region name to group the metrics in a region tag. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to identify resource ownership. | <pre>object({<br>    team    = string<br>    impact  = string<br>    service = string<br>  })</pre> | n/a | yes |
| <a name="input_template_file"></a> [template\_file](#input\_template\_file) | The template file to use for datadog. If no template file is specified it will use the default one. | `string` | `""` | no |
| <a name="input_template_values"></a> [template\_values](#input\_template\_values) | The values to use for resolve the template. | `map(string)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Time in seconds to wait for release installation. | `number` | `600` | no |
| <a name="input_use_custom_image"></a> [use\_custom\_image](#input\_use\_custom\_image) | Whether to use the custom powise-managed Agent with the Gatekeeper integration enabled. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_agent_role_arn"></a> [agent\_role\_arn](#output\_agent\_role\_arn) | ARN of the Datadog agent IAM role. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
