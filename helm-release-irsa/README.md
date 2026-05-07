# helm-release-irsa

This module manages a helm release & IRSA role creation.
It can do it in two ways:
- via terraform helm release
- creating an ArgoCD application to be managed via gitops
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_helm_release"></a> [helm\_release](#module\_helm\_release) | ../helm-release | n/a |
| <a name="module_irsa"></a> [irsa](#module\_irsa) | ../../eks/irsa | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_helm_config"></a> [additional\_helm\_config](#input\_additional\_helm\_config) | Release helm chart config, provide repository and version at the minimum.<br>See https://registry.terraform.io/providers/hashicorp/helm/latest/docs. | `any` | `{}` | no |
| <a name="input_argocd_app_config"></a> [argocd\_app\_config](#input\_argocd\_app\_config) | ArgoCD Application config. See k8s/argocd/resources/application | `any` | `{}` | no |
| <a name="input_chart"></a> [chart](#input\_chart) | Helm chart name - a [well known] name of the software package itself. | `string` | `null` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Exact Helm chart version to install. | `string` | `"HEAD"` | no |
| <a name="input_create_irsa"></a> [create\_irsa](#input\_create\_irsa) | Whether to create IRSA or not. | `bool` | `true` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if it does not yet exist. | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Helm release description. | `string` | `""` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | EKS cluster to get OIDC issuer/authorize from. | `string` | n/a | yes |
| <a name="input_force_update"></a> [force\_update](#input\_force\_update) | Force resource update through delete/recreate if needed. | `bool` | `false` | no |
| <a name="input_iam_permissions_boundary"></a> [iam\_permissions\_boundary](#input\_iam\_permissions\_boundary) | IAM permissions boundary for IRSA roles | `string` | `""` | no |
| <a name="input_iam_policy_arns"></a> [iam\_policy\_arns](#input\_iam\_policy\_arns) | IAM policy ARNs for IRSA IAM role. | `list(string)` | `[]` | no |
| <a name="input_iam_policy_documents"></a> [iam\_policy\_documents](#input\_iam\_policy\_documents) | Documents to create inline IAM policies for IRSA IAM role. | `map(string)` | `{}` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | Name of the IAM role to create. | `string` | `""` | no |
| <a name="input_iam_role_path"></a> [iam\_role\_path](#input\_iam\_role\_path) | IAM role path for IRSA roles. | `string` | `null` | no |
| <a name="input_kustomization_file"></a> [kustomization\_file](#input\_kustomization\_file) | Path to a kustomization.yaml file that will be used to change helm-managed resources via postrender. It should be an overlay that, at a minimum, uses "base.yaml" as a resource. | `string` | `null` | no |
| <a name="input_manage_via_argocd"></a> [manage\_via\_argocd](#input\_manage\_via\_argocd) | Determines if the release should be managed via ArgoCD. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | An arbitrary name of the software package installation (kinda "chart instance"). | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace to install this chart release into. | `string` | n/a | yes |
| <a name="input_node_selector"></a> [node\_selector](#input\_node\_selector) | Node Selector for the deployment | `map(string)` | `{}` | no |
| <a name="input_repo_path"></a> [repo\_path](#input\_repo\_path) | Path in the repo. Only used for git repos. | `string` | `null` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Repository URL where to locate the requested chart. | `string` | `"https://kubernetes-charts.storage.googleapis.com"` | no |
| <a name="input_reset_values"></a> [reset\_values](#input\_reset\_values) | When upgrading, reset the values to the ones built into the chart. | `bool` | `false` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | Kubernetes Service Account Name | `string` | `null` | no |
| <a name="input_service_account_helm_config"></a> [service\_account\_helm\_config](#input\_service\_account\_helm\_config) | Helm Paths to configure Service Account | <pre>object({<br>    create_path      = string<br>    annotations_path = string<br>    name_path        = string<br>  })</pre> | <pre>{<br>  "annotations_path": "serviceAccount.annotations",<br>  "create_path": "serviceAccount.create",<br>  "name_path": "serviceAccount.name"<br>}</pre> | no |
| <a name="input_set_sensitive_values"></a> [set\_sensitive\_values](#input\_set\_sensitive\_values) | Value blocks to be merged with the values YAML without being exposed in plan diff. | `map(string)` | `{}` | no |
| <a name="input_set_sensitive_values_from_ssm"></a> [set\_sensitive\_values\_from\_ssm](#input\_set\_sensitive\_values\_from\_ssm) | Secret "name:ssm\_path" blocks to be fetched from SSM and merged with the values YAML. | `map(string)` | `{}` | no |
| <a name="input_set_string_values"></a> [set\_string\_values](#input\_set\_string\_values) | Value blocks to be merged with the values YAML, explicitly as strings with no magic type conversion. | `map(string)` | `{}` | no |
| <a name="input_set_values"></a> [set\_values](#input\_set\_values) | Value blocks to be merged with the values YAML. | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to AWS resources. | `map(string)` | n/a | yes |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Time in seconds to wait for release installation. | `number` | `600` | no |
| <a name="input_tolerations"></a> [tolerations](#input\_tolerations) | Tolerations for the deployment | <pre>list(object({<br>    key      = string<br>    operator = string<br>    value    = optional(string)<br>    effect   = string<br>  }))</pre> | `[]` | no |
| <a name="input_value_files"></a> [value\_files](#input\_value\_files) | Helm values files for overriding values in the helm chart. | `list(string)` | `[]` | no |
| <a name="input_values"></a> [values](#input\_values) | List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options. | `list(string)` | `[]` | no |
| <a name="input_wait"></a> [wait](#input\_wait) | Will wait until all resources are in a ready state before marking the release as successful. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_helm_config"></a> [helm\_config](#output\_helm\_config) | Helm Config to be used by GitOps tools. |
| <a name="output_irsa_iam_role_arn"></a> [irsa\_iam\_role\_arn](#output\_irsa\_iam\_role\_arn) | IAM role ARN for your service account |
| <a name="output_irsa_iam_role_name"></a> [irsa\_iam\_role\_name](#output\_irsa\_iam\_role\_name) | IAM role name for your service account |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
