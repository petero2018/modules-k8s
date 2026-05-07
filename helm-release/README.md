# helm-release

This module manages a helm release.
It can do it in two ways:
- via terraform helm release
- creating an ArgoCD application to be managed via gitops

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | <3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=4.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | <3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_argo_app"></a> [argo\_app](#module\_argo\_app) | ../argocd-application | n/a |

## Resources

| Name | Type |
|------|------|
| [helm_release.release](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [aws_ssm_parameter.sensitive](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_helm_config"></a> [additional\_helm\_config](#input\_additional\_helm\_config) | Release helm chart config, provide repository and version at the minimum.<br>See https://registry.terraform.io/providers/hashicorp/helm/latest/docs. | `any` | `{}` | no |
| <a name="input_argocd_app_config"></a> [argocd\_app\_config](#input\_argocd\_app\_config) | ArgoCD Application config. See k8s/argocd/resources/application | `any` | `{}` | no |
| <a name="input_chart"></a> [chart](#input\_chart) | Helm chart name - a [well known] name of the software package itself. | `string` | n/a | yes |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Exact Helm chart version to install. | `string` | n/a | yes |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if it does not yet exist. | `bool` | `false` | no |
| <a name="input_deploy_arch"></a> [deploy\_arch](#input\_deploy\_arch) | Node architecture to deploy to. Must be either "amd64" or "arm64" | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | Helm release description. | `string` | `""` | no |
| <a name="input_enable_oci"></a> [enable\_oci](#input\_enable\_oci) | whether helm repository is OCI. | `bool` | `false` | no |
| <a name="input_force_update"></a> [force\_update](#input\_force\_update) | Force resource update through delete/recreate if needed. | `bool` | `false` | no |
| <a name="input_kustomization_file"></a> [kustomization\_file](#input\_kustomization\_file) | Path to a kustomization.yaml file that will be used to change helm-managed resources via postrender. It should be an overlay that, at a minimum, uses "base.yaml" as a resource. | `string` | `null` | no |
| <a name="input_manage_via_argocd"></a> [manage\_via\_argocd](#input\_manage\_via\_argocd) | Determines if the release should be managed via ArgoCD. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | An arbitrary name of the software package installation (kinda "chart instance"). | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace to install this chart release into. | `string` | n/a | yes |
| <a name="input_repo_path"></a> [repo\_path](#input\_repo\_path) | Path in the repo. Only used for git repos. | `string` | `null` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Repository URL where to locate the requested chart. | `string` | `"https://kubernetes-charts.storage.googleapis.com"` | no |
| <a name="input_reset_values"></a> [reset\_values](#input\_reset\_values) | When upgrading, reset the values to the ones built into the chart. | `bool` | `false` | no |
| <a name="input_set_sensitive_values"></a> [set\_sensitive\_values](#input\_set\_sensitive\_values) | Value blocks to be merged with the values YAML without being exposed in plan diff. | `map(string)` | `{}` | no |
| <a name="input_set_sensitive_values_from_ssm"></a> [set\_sensitive\_values\_from\_ssm](#input\_set\_sensitive\_values\_from\_ssm) | Secret "name:ssm\_path" blocks to be fetched from SSM and merged with the values YAML. | `map(string)` | `{}` | no |
| <a name="input_set_string_values"></a> [set\_string\_values](#input\_set\_string\_values) | Value blocks to be merged with the values YAML, explicitly as strings with no magic type conversion. | `map(string)` | `{}` | no |
| <a name="input_set_values"></a> [set\_values](#input\_set\_values) | Value blocks to be merged with the values YAML. | `map(string)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Time in seconds to wait for release installation. | `number` | `600` | no |
| <a name="input_value_files"></a> [value\_files](#input\_value\_files) | Helm values files for overriding values in the helm chart. | `list(string)` | `[]` | no |
| <a name="input_values"></a> [values](#input\_values) | List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options. | `list(string)` | `[]` | no |
| <a name="input_wait"></a> [wait](#input\_wait) | Will wait until all resources are in a ready state before marking the release as successful. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_version"></a> [app\_version](#output\_app\_version) | The version of the app installed by the Helm chart. |
| <a name="output_helm_config"></a> [helm\_config](#output\_helm\_config) | Helm Config to be used by GitOps tools. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
