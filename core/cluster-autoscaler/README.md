# Cluster Autoscaler

Install [Cluster Autoscaler](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler) helm chart.

Cluster Autoscaler is a tool that automatically adjusts the size of the Kubernetes cluster when one of the following conditions is true:

* there are pods that failed to run in the cluster due to insufficient resources.
* there are nodes in the cluster that have been underutilized for an extended period of time and their pods can be placed on other existing nodes.

Also configures `Overprovisioning`:
* https://medium.com/scout24-engineering/cluster-overprovisiong-in-kubernetes-79433cb3ed0e
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cluster_autoscaler"></a> [cluster\_autoscaler](#module\_cluster\_autoscaler) | git@github.com:powise/terraform-modules//k8s/helm-release | helm-release-0.3.3 |
| <a name="module_cluster_autoscaler_role"></a> [cluster\_autoscaler\_role](#module\_cluster\_autoscaler\_role) | git@github.com:powise/terraform-modules//eks/oidc-role | oidc-role-0.0.2 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.cluster_autoscaler_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_autoscaler_chart_version"></a> [cluster\_autoscaler\_chart\_version](#input\_cluster\_autoscaler\_chart\_version) | The version of cluster autoscaler chart to install. | `string` | n/a | yes |
| <a name="input_cluster_autoscaler_config"></a> [cluster\_autoscaler\_config](#input\_cluster\_autoscaler\_config) | Cluster Autoscaler configuration. | <pre>object({<br>    scale_down_utilization_threshold = string,<br>    skip_nodes_with_local_storage    = bool,<br>    scale_down_unneeded_time         = string,<br>    image_tag                        = string<br>  })</pre> | <pre>{<br>  "image_tag": "v1.23.0",<br>  "scale_down_unneeded_time": "10m",<br>  "scale_down_utilization_threshold": "0.6",<br>  "skip_nodes_with_local_storage": false<br>}</pre> | no |
| <a name="input_cluster_autoscaler_helm_config"></a> [cluster\_autoscaler\_helm\_config](#input\_cluster\_autoscaler\_helm\_config) | Helm provider config for cluster autoscaler | `any` | `{}` | no |
| <a name="input_cluster_autoscaler_namespace"></a> [cluster\_autoscaler\_namespace](#input\_cluster\_autoscaler\_namespace) | The namespace to install the components in. | `string` | `"kube-system"` | no |
| <a name="input_cluster_autoscaler_template_file"></a> [cluster\_autoscaler\_template\_file](#input\_cluster\_autoscaler\_template\_file) | The template file to use for cluster autoscaler. If no template file is specified it will use the default one. | `string` | `""` | no |
| <a name="input_cluster_autoscaler_template_values"></a> [cluster\_autoscaler\_template\_values](#input\_cluster\_autoscaler\_template\_values) | The values to use for resolve the template. | `map(string)` | `{}` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Name of the EKS cluster to deploy into. | `string` | n/a | yes |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Time in seconds to wait for release installation. | `number` | `600` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
