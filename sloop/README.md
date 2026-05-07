# Sloop

Sloop monitors Kubernetes, recording histories of events and resource state changes and providing visualizations to aid in debugging past events.

https://github.com/salesforce/sloop/tree/master
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
| <a name="module_release"></a> [release](#module\_release) | ../argocd-application | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argocd_app_config"></a> [argocd\_app\_config](#input\_argocd\_app\_config) | ArgoCD Application config. See k8s/argocd/resources/application | `any` | `{}` | no |
| <a name="input_crd_api_groups"></a> [crd\_api\_groups](#input\_crd\_api\_groups) | List of CRD API Groups to monitor | `list(string)` | `[]` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if it does not yet exist. | `bool` | `true` | no |
| <a name="input_enable_ingress"></a> [enable\_ingress](#input\_enable\_ingress) | Enables Sloop ingress. | `bool` | `false` | no |
| <a name="input_git_version"></a> [git\_version](#input\_git\_version) | The version of github to install. Can be a branch / tag. | `string` | n/a | yes |
| <a name="input_ingress_class"></a> [ingress\_class](#input\_ingress\_class) | Ingress class to use. | `string` | `""` | no |
| <a name="input_ingress_domain"></a> [ingress\_domain](#input\_ingress\_domain) | Ingress domain to use. | `string` | `""` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to install the components in. | `string` | `"sloop"` | no |
| <a name="input_pv_class"></a> [pv\_class](#input\_pv\_class) | Storage class to use. undefined will fall back to the cluster default. | `string` | `null` | no |
| <a name="input_pv_size"></a> [pv\_size](#input\_pv\_size) | Storage size. | `string` | `"10Gi"` | no |
| <a name="input_pv_size_max"></a> [pv\_size\_max](#input\_pv\_size\_max) | Max Storage size. | `string` | `"12Gi"` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Time in seconds to wait for release installation. | `number` | `1200` | no |
| <a name="input_watch_crd"></a> [watch\_crd](#input\_watch\_crd) | Flag to watch CRD. | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
