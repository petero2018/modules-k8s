# logstash

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_irsa"></a> [irsa](#module\_irsa) | ../../eks/irsa | n/a |
| <a name="module_logstash"></a> [logstash](#module\_logstash) | git@github.com:powise/terraform-modules//k8s/helm-release | helm-release-0.3.2 |
| <a name="module_namespace"></a> [namespace](#module\_namespace) | git@github.com:powise/terraform-modules//k8s/core/namespace | core-namespace-2.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argocd_app_config"></a> [argocd\_app\_config](#input\_argocd\_app\_config) | ArgoCD Application config. See k8s/argocd/resources/application | `any` | `{}` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | The version of Logstash to install. | `string` | n/a | yes |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if it does not yet exist. | `bool` | `true` | no |
| <a name="input_deploy_arch"></a> [deploy\_arch](#input\_deploy\_arch) | Node architecture to deploy to. Must be either "amd64" or "arm64" | `string` | `"arm64"` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | The EKS cluster in which Logstash will be installed. | `string` | n/a | yes |
| <a name="input_enable_ecs_compatibility"></a> [enable\_ecs\_compatibility](#input\_enable\_ecs\_compatibility) | Whether to enable Elasic Common Schema compatibility mode | `string` | `"disabled"` | no |
| <a name="input_enable_iam"></a> [enable\_iam](#input\_enable\_iam) | Authenticate to the opensearch endpoint(s) via IAM permissions | `bool` | `true` | no |
| <a name="input_enable_istio"></a> [enable\_istio](#input\_enable\_istio) | Whether to add logstash to the cluster's Istio service mesh. | `bool` | `false` | no |
| <a name="input_enable_multiple_pipeline_support"></a> [enable\_multiple\_pipeline\_support](#input\_enable\_multiple\_pipeline\_support) | If set to true, each entry in the pipelines variable run as a separate pipeline | `bool` | `false` | no |
| <a name="input_extra_iam_policies"></a> [extra\_iam\_policies](#input\_extra\_iam\_policies) | Additional IAM policies that will be attached to Logstash's IAM role | `map(string)` | `{}` | no |
| <a name="input_helm_config"></a> [helm\_config](#input\_helm\_config) | Helm provider config for Kubecost | `any` | `{}` | no |
| <a name="input_iam_prefix"></a> [iam\_prefix](#input\_iam\_prefix) | First part of the IAM role name. | `string` | `"logstash"` | no |
| <a name="input_iam_suffix"></a> [iam\_suffix](#input\_iam\_suffix) | Will be appended to the end of IAM-related resources to help maintain uniqueness in multi-cluster/multi-region setups | `string` | `null` | no |
| <a name="input_image_repository"></a> [image\_repository](#input\_image\_repository) | Docker image repository for Logstash. | `string` | `"opensearchproject/logstash-oss-with-opensearch-output-plugin"` | no |
| <a name="input_java_opts"></a> [java\_opts](#input\_java\_opts) | Logstash JVM memory settings. | `string` | `"-Xmx1g -Xms1g"` | no |
| <a name="input_logstash_version"></a> [logstash\_version](#input\_logstash\_version) | The version of the logstash image to use. | `string` | `"8.6.1"` | no |
| <a name="input_manage_via_argocd"></a> [manage\_via\_argocd](#input\_manage\_via\_argocd) | Determines if the release should be managed via ArgoCD. | `bool` | `false` | no |
| <a name="input_max_unavailable"></a> [max\_unavailable](#input\_max\_unavailable) | The maximum number of Logstash pods that can be unavailable during an update or disruption. | `number` | `1` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the installation, used for ServiceAccount & IAM role names. | `string` | `"logstash"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to install the components in. | `string` | `"logstash"` | no |
| <a name="input_opensearch_arns"></a> [opensearch\_arns](#input\_opensearch\_arns) | A list of opensearch cluster ARNs into which logstash will be granted permission to send logs. | `list(string)` | n/a | yes |
| <a name="input_patterns"></a> [patterns](#input\_patterns) | Patterns that will be injected into the configmap and used by Logstash to parse logs | `map(string)` | `{}` | no |
| <a name="input_pipeline_batch_size"></a> [pipeline\_batch\_size](#input\_pipeline\_batch\_size) | Maximum pipeline batch size. | `number` | `125` | no |
| <a name="input_pipeline_workers"></a> [pipeline\_workers](#input\_pipeline\_workers) | Set the number of pipeline workers, optional (defaults to the number of CPUs). | `number` | `null` | no |
| <a name="input_pipelines"></a> [pipelines](#input\_pipelines) | Pipelines that will be injected into the applicable configmap | `map(string)` | `{}` | no |
| <a name="input_ports"></a> [ports](#input\_ports) | Each port required by pipelines must be configured here to allow ingress | <pre>list(object({<br>    name           = string<br>    container_port = number<br>  }))</pre> | `[]` | no |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | How many instances of logstash to run in the statefulset. | `number` | `3` | no |
| <a name="input_resource_limits"></a> [resource\_limits](#input\_resource\_limits) | Logstash pods resource limits. | <pre>object({<br>    cpu    = optional(string, "1000m")<br>    memory = optional(string, "1792Mi")<br>  })</pre> | `{}` | no |
| <a name="input_resource_requests"></a> [resource\_requests](#input\_resource\_requests) | Logstash pods resource requests. | <pre>object({<br>    cpu    = optional(string, "100m")<br>    memory = optional(string, "1792Mi")<br>  })</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to identify resources ownership | `map(string)` | n/a | yes |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Time in seconds to wait for release installation. | `number` | `600` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | Logstash IAM role ARN (if created). |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
