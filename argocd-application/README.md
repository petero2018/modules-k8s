# ArgoCD Application

Creates an ArgoCD application using the ArgoCD CRD.
https://github.com/argoproj/argo-cd/blob/master/docs/operator-manual/application.yaml

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.16.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.16.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_manifest.application](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart"></a> [chart](#input\_chart) | Helm chart to install. Only used for helm chart repos. | `string` | `null` | no |
| <a name="input_destination_namespace"></a> [destination\_namespace](#input\_destination\_namespace) | Destination namespace to create the resources in. | `string` | n/a | yes |
| <a name="input_file_values"></a> [file\_values](#input\_file\_values) | Use the contents of files as parameters (uses Helm's --set-file) | <pre>list(object({<br>    name = string<br>    path = string<br>  }))</pre> | `[]` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to be applied to Application. | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the ArgoCD Application | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace where ArgoCD is installed. | `string` | `"argocd"` | no |
| <a name="input_project"></a> [project](#input\_project) | ArgoCD Project to add the | `string` | n/a | yes |
| <a name="input_release_name"></a> [release\_name](#input\_release\_name) | Helm Release name. defaults to application name. | `string` | `null` | no |
| <a name="input_repo_path"></a> [repo\_path](#input\_repo\_path) | Path in the repo. Only used for git repos. | `string` | `null` | no |
| <a name="input_repo_url"></a> [repo\_url](#input\_repo\_url) | Repository URL. Can be a Helm chart repo or a git repo. | `string` | n/a | yes |
| <a name="input_set_sensitive_values"></a> [set\_sensitive\_values](#input\_set\_sensitive\_values) | Value blocks to be merged with the values YAML without being exposed in plan diff. | `map(string)` | `{}` | no |
| <a name="input_set_string_values"></a> [set\_string\_values](#input\_set\_string\_values) | Value blocks to be merged with the values YAML, explicitly as strings with no magic type conversion. | `map(string)` | `{}` | no |
| <a name="input_set_values"></a> [set\_values](#input\_set\_values) | Value blocks to be merged with the values YAML. | `map(string)` | `{}` | no |
| <a name="input_sync_automated"></a> [sync\_automated](#input\_sync\_automated) | Automatically Sync the app when it detects differences between the desired manifests in Git, and the live state in the cluster. | `bool` | `true` | no |
| <a name="input_sync_automated_allow_empty"></a> [sync\_automated\_allow\_empty](#input\_sync\_automated\_allow\_empty) | Allows deleting all application resources during automatic syncing. Only if automated is true. | `bool` | `false` | no |
| <a name="input_sync_automated_prune"></a> [sync\_automated\_prune](#input\_sync\_automated\_prune) | Specifies if resources should be pruned during auto-syncing. Only if automated is true. | `bool` | `true` | no |
| <a name="input_sync_automated_self_heal"></a> [sync\_automated\_self\_heal](#input\_sync\_automated\_self\_heal) | Specifies if partial app sync should be executed when resources are changed only in target Kubernetes cluster and no git change detected. Only if automated is true. | `bool` | `true` | no |
| <a name="input_sync_backoff_duration"></a> [sync\_backoff\_duration](#input\_sync\_backoff\_duration) | The amount to back off. Default unit is seconds, but could also be a duration (e.g. "2m", "1h"). | `string` | `"5s"` | no |
| <a name="input_sync_backoff_factor"></a> [sync\_backoff\_factor](#input\_sync\_backoff\_factor) | A factor to multiply the base duration after each failed retry. | `number` | `2` | no |
| <a name="input_sync_backoff_max_duration"></a> [sync\_backoff\_max\_duration](#input\_sync\_backoff\_max\_duration) | The maximum amount of time allowed for the backoff strategy. | `string` | `"3m"` | no |
| <a name="input_sync_create_namespace"></a> [sync\_create\_namespace](#input\_sync\_create\_namespace) | Namespace Auto-Creation ensures that namespace specified as the application destination exists in the destination cluster. | `bool` | `false` | no |
| <a name="input_sync_prune_last"></a> [sync\_prune\_last](#input\_sync\_prune\_last) | Allow the ability for resource pruning to happen as a final, implicit wave of a sync operation. | `bool` | `true` | no |
| <a name="input_sync_prune_propagation_policy"></a> [sync\_prune\_propagation\_policy](#input\_sync\_prune\_propagation\_policy) | Prune propagation policy. | `string` | `"foreground"` | no |
| <a name="input_sync_retry"></a> [sync\_retry](#input\_sync\_retry) | Number of failed sync attempt retries; unlimited number of attempts if less than 0. | `number` | `5` | no |
| <a name="input_sync_validate"></a> [sync\_validate](#input\_sync\_validate) | Enables resource validation. (equivalent to 'kubectl apply --validate=') | `bool` | `true` | no |
| <a name="input_target_revision"></a> [target\_revision](#input\_target\_revision) | Target revision. For helm this refers to the chart version. | `string` | `null` | no |
| <a name="input_value_files"></a> [value\_files](#input\_value\_files) | Helm values files for overriding values in the helm chart. | `list(string)` | `[]` | no |
| <a name="input_values"></a> [values](#input\_values) | List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options. | `list(string)` | `[]` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
