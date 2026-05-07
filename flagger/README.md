# flagger

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.6 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | != 2.4.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.7.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | != 2.4.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.7.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.flagger](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_cluster_role.group_custom_resources](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role.user_custom_resources](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role_binding.group_custom_resources](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_cluster_role_binding.user_custom_resources](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_namespace.flagger](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_role_binding.group_view](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.user_view](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_secret.datadog_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart_timeout"></a> [chart\_timeout](#input\_chart\_timeout) | Helm chart installation timeout in seconds. | `number` | `600` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | A version of Flagger Helm chart we want to install. | `string` | n/a | yes |
| <a name="input_datadog_api_key"></a> [datadog\_api\_key](#input\_datadog\_api\_key) | Datadog API key. | `string` | `null` | no |
| <a name="input_datadog_app_key"></a> [datadog\_app\_key](#input\_datadog\_app\_key) | Datadog application key. | `string` | `null` | no |
| <a name="input_deploy_arch"></a> [deploy\_arch](#input\_deploy\_arch) | Node architecture to deploy to. Must be either "amd64" or "arm64" | `string` | `"arm64"` | no |
| <a name="input_flagger_request_cpu"></a> [flagger\_request\_cpu](#input\_flagger\_request\_cpu) | resources.requests.cpu for Flagger's k8s operator | `string` | `"200m"` | no |
| <a name="input_flagger_request_memory"></a> [flagger\_request\_memory](#input\_flagger\_request\_memory) | resources.requests.memory for Flagger's k8s operator | `string` | `"200m"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace to install this chart release into. | `string` | n/a | yes |
| <a name="input_rbac_groups"></a> [rbac\_groups](#input\_rbac\_groups) | List of groups allowed to enumerate resources in flagger namespace. | `list(string)` | n/a | yes |
| <a name="input_rbac_groups_readonly"></a> [rbac\_groups\_readonly](#input\_rbac\_groups\_readonly) | Are RBAC groups limited to read-only actions only? | `bool` | n/a | yes |
| <a name="input_rbac_users"></a> [rbac\_users](#input\_rbac\_users) | List of users allowed to enumerate resources in flagger namespace. | `list(string)` | n/a | yes |
| <a name="input_rbac_users_readonly"></a> [rbac\_users\_readonly](#input\_rbac\_users\_readonly) | Are RBAC users limited to read-only actions only? | `bool` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
