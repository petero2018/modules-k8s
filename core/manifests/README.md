# manifests

This module deploys and configures common resources such as vpc cni, datadog, filebeat and others on a kubernetes cluster.

## DEPRECATED!!

This module will be removed soon and should not be used anymore. Instead you should use individual modules existing on this repo for anything that is included by this "fat" module.

### But why?

"Fat" modules make it harder to re-use and to maintain because they will most likely not suite all use cases for all of our teams. Instead, using thinner and more generic modules will make it easier to re-use and to maintain.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.13.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.7.1 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.13.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.7.1 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_load_balancer_controller"></a> [aws\_load\_balancer\_controller](#module\_aws\_load\_balancer\_controller) | git@github.com:powise/terraform-modules//k8s/helm-release | helm-release-0.3.1 |
| <a name="module_aws_load_balancer_controller_role"></a> [aws\_load\_balancer\_controller\_role](#module\_aws\_load\_balancer\_controller\_role) | git@github.com:powise/terraform-modules//eks/oidc-role | oidc-role-0.0.1 |
| <a name="module_aws_vpc_cni"></a> [aws\_vpc\_cni](#module\_aws\_vpc\_cni) | git@github.com:powise/terraform-modules//k8s/helm-release | helm-release-0.3.1 |
| <a name="module_cluster_autoscaler"></a> [cluster\_autoscaler](#module\_cluster\_autoscaler) | git@github.com:powise/terraform-modules//k8s/helm-release | helm-release-0.3.1 |
| <a name="module_cluster_autoscaler_role"></a> [cluster\_autoscaler\_role](#module\_cluster\_autoscaler\_role) | git@github.com:powise/terraform-modules//eks/oidc-role | oidc-role-0.0.1 |
| <a name="module_datadog"></a> [datadog](#module\_datadog) | git@github.com:powise/terraform-modules//k8s/helm-release | helm-release-0.3.1 |
| <a name="module_external_dns"></a> [external\_dns](#module\_external\_dns) | git@github.com:powise/terraform-modules//k8s/helm-release | helm-release-0.3.1 |
| <a name="module_external_dns_role"></a> [external\_dns\_role](#module\_external\_dns\_role) | git@github.com:powise/terraform-modules//eks/oidc-role | oidc-role-0.0.1 |
| <a name="module_filebeat"></a> [filebeat](#module\_filebeat) | git@github.com:powise/terraform-modules//k8s/helm-release | helm-release-0.3.1 |
| <a name="module_flagger"></a> [flagger](#module\_flagger) | git@github.com:powise/terraform-modules//k8s/flagger | flagger-1.0.3 |
| <a name="module_overprovisioning"></a> [overprovisioning](#module\_overprovisioning) | git@github.com:powise/terraform-modules//k8s/overprovisioning | overprovisioning-0.0.7 |
| <a name="module_overprovisioning_proportional_autoscaler"></a> [overprovisioning\_proportional\_autoscaler](#module\_overprovisioning\_proportional\_autoscaler) | git@github.com:powise/terraform-modules//k8s/helm-release | helm-release-0.3.1 |

## Resources

| Name | Type |
|------|------|
| [aws_eks_addon.core_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.kube_proxy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.vpc_cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [kubectl_manifest.aws_load_balancer_controller_crds](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.metrics_server](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace.overprovisioning](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_priority_class.overprovisioning](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/priority_class) | resource |
| [null_resource.drain_nodes_from_cluster](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.import_aws_vpc_cni_plugin](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_eks_cluster.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [aws_iam_policy_document.external_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [kubectl_file_documents.metrics_server](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/file_documents) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_external_dns_zone_ids"></a> [allow\_external\_dns\_zone\_ids](#input\_allow\_external\_dns\_zone\_ids) | List of Route53 hosted zone IDs we allow ExternalDNS to access. | `list(string)` | `[]` | no |
| <a name="input_aws_cluster_autoscaler_chart_version"></a> [aws\_cluster\_autoscaler\_chart\_version](#input\_aws\_cluster\_autoscaler\_chart\_version) | Chart version to deploy for AWS Cluster Autoscaler. | `string` | n/a | yes |
| <a name="input_aws_cluster_autoscaler_image_tag"></a> [aws\_cluster\_autoscaler\_image\_tag](#input\_aws\_cluster\_autoscaler\_image\_tag) | Version to deploy for AWS Load Balancer Controller. | `string` | n/a | yes |
| <a name="input_aws_load_balancer_controller_chart_version"></a> [aws\_load\_balancer\_controller\_chart\_version](#input\_aws\_load\_balancer\_controller\_chart\_version) | Chart version to deploy for AWS Load Balancer Controller. | `string` | n/a | yes |
| <a name="input_cluster_autoscaler_config"></a> [cluster\_autoscaler\_config](#input\_cluster\_autoscaler\_config) | Cluster Autoscaler configuration. | <pre>object({<br>    scale_down_utilization_threshold = string,<br>    skip_nodes_with_local_storage    = bool,<br>    scale_down_unneeded_time         = string,<br>  })</pre> | <pre>{<br>  "scale_down_unneeded_time": "10m",<br>  "scale_down_utilization_threshold": "0.6",<br>  "skip_nodes_with_local_storage": false<br>}</pre> | no |
| <a name="input_coredns_version"></a> [coredns\_version](#input\_coredns\_version) | "CoreDNS" EKS addon version. | `string` | `"v1.8.3-eksbuild.1"` | no |
| <a name="input_daemonset_helm_timeout"></a> [daemonset\_helm\_timeout](#input\_daemonset\_helm\_timeout) | Timeout to install/update daemonset (Datadog and Filebeat) charts. | `number` | `600` | no |
| <a name="input_datadog_api_key_ssm_path"></a> [datadog\_api\_key\_ssm\_path](#input\_datadog\_api\_key\_ssm\_path) | SSM parameter name (path) for the Datadog API key. | `string` | `null` | no |
| <a name="input_datadog_app_key_ssm_path"></a> [datadog\_app\_key\_ssm\_path](#input\_datadog\_app\_key\_ssm\_path) | SSM parameter name (path) for the Datadog application key. | `string` | `null` | no |
| <a name="input_datadog_chart_version"></a> [datadog\_chart\_version](#input\_datadog\_chart\_version) | A version of Datadog chart to install. | `string` | `"2.19.2"` | no |
| <a name="input_datadog_checks_cardinality"></a> [datadog\_checks\_cardinality](#input\_datadog\_checks\_cardinality) | Add tags to check metrics (low, orchestrator, high). More info here: https://docs.datadoghq.com/getting_started/tagging/assigning_tags/?tab=containerizedenvironments#environment-variables | `string` | `"low"` | no |
| <a name="input_datadog_environment"></a> [datadog\_environment](#input\_datadog\_environment) | Datadog environment tag override (use on inactive prod clusters to not confuse dashboards and monitors). | `string` | `null` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Name of the EKS cluster to deploy into. | `string` | n/a | yes |
| <a name="input_enable_cluster_autoscaler"></a> [enable\_cluster\_autoscaler](#input\_enable\_cluster\_autoscaler) | Enable Cluster Autoscaler component. | `bool` | `false` | no |
| <a name="input_enable_core_components_logs"></a> [enable\_core\_components\_logs](#input\_enable\_core\_components\_logs) | Forward core component logs (e.g. kube-system components, datadog...) to ELK stack. Note: this only adds a field to Filebeat events, filtering is done in Logstash. | `bool` | `false` | no |
| <a name="input_enable_datadog_apm"></a> [enable\_datadog\_apm](#input\_enable\_datadog\_apm) | Enable datadog APM and tracing. | `bool` | `false` | no |
| <a name="input_enable_datadog_logs"></a> [enable\_datadog\_logs](#input\_enable\_datadog\_logs) | Enable datadog log collection. | `bool` | `false` | no |
| <a name="input_enable_external_dns"></a> [enable\_external\_dns](#input\_enable\_external\_dns) | Enable ExternalDNS component (set "true" for non-production clusters). | `bool` | `false` | no |
| <a name="input_enable_flagger"></a> [enable\_flagger](#input\_enable\_flagger) | Enable Flagger, a progressive delivery tool (set "true" for dev and prod clusters). | `bool` | `false` | no |
| <a name="input_enable_security_group_policies"></a> [enable\_security\_group\_policies](#input\_enable\_security\_group\_policies) | Enable security group policies (set "true" to support security groups for pods). | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Deploy environment ("dev", "prod" or "tools"). | `string` | n/a | yes |
| <a name="input_filebeat_chart_version"></a> [filebeat\_chart\_version](#input\_filebeat\_chart\_version) | Version of Filebeat helm chart to install. | `string` | `"7.13.2"` | no |
| <a name="input_flagger_chart_version"></a> [flagger\_chart\_version](#input\_flagger\_chart\_version) | Version of Flagger helm chart to install. | `string` | `"1.13.0"` | no |
| <a name="input_kube_proxy_version"></a> [kube\_proxy\_version](#input\_kube\_proxy\_version) | "kube-proxy" EKS addon version. | `string` | `"v1.20.4-eksbuild.2"` | no |
| <a name="input_kube_status"></a> [kube\_status](#input\_kube\_status) | Cluster status. "active" or "inactive"? | `string` | `"active"` | no |
| <a name="input_logstash_redis_host"></a> [logstash\_redis\_host](#input\_logstash\_redis\_host) | Host of the redis endpoint for filebeat output (logstash input). | `string` | `"logstash-tfprod.zuxcwv.0001.use1.cache.amazonaws.com"` | no |
| <a name="input_overprovisioning_configs"></a> [overprovisioning\_configs](#input\_overprovisioning\_configs) | Config object for the cluster resource "ballast" buffers. | <pre>list(object({<br>    name            = string,<br>    node_group_name = string,<br>    min_replicas    = number,<br>    max_replicas    = number,<br>    slack_pct       = number,<br>  }))</pre> | <pre>[<br>  {<br>    "max_replicas": 80,<br>    "min_replicas": 20,<br>    "name": "overprovisioning",<br>    "node_group_name": "",<br>    "slack_pct": 20<br>  }<br>]</pre> | no |
| <a name="input_product"></a> [product](#input\_product) | Name of the product deployed to this cluster. | `string` | `"generic"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to identify resources ownership | <pre>object({<br>    team    = string<br>    impact  = string<br>    service = string<br>  })</pre> | n/a | yes |
| <a name="input_vpc_cni_chart_version"></a> [vpc\_cni\_chart\_version](#input\_vpc\_cni\_chart\_version) | "VPC CNI" EKS addon helm chart version. | `string` | `"1.1.10"` | no |
| <a name="input_vpc_cni_version"></a> [vpc\_cni\_version](#input\_vpc\_cni\_version) | "VPC CNI" EKS addon version. | `string` | `"v1.8.0-eksbuild.1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks_cluster"></a> [eks\_cluster](#output\_eks\_cluster) | Name of the EKS cluster to deploy into. |
| <a name="output_environment"></a> [environment](#output\_environment) | Deploy environment. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
