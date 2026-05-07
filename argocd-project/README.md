# ArgoCD Project

Creates an ArgoCD project using the ArgoCD CRD.
https://github.com/argoproj/argo-cd/blob/master/docs/operator-manual/project.yaml

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
| <a name="input_cluster_resource_allow_list"></a> [cluster\_resource\_allow\_list](#input\_cluster\_resource\_allow\_list) | List of cluster resources allowed to be created by this project. | <pre>list(object({<br>    group = string<br>    kind  = string<br>  }))</pre> | <pre>[<br>  {<br>    "group": "",<br>    "kind": "Namespace"<br>  }<br>]</pre> | no |
| <a name="input_description"></a> [description](#input\_description) | Project description. | `string` | n/a | yes |
| <a name="input_destinations"></a> [destinations](#input\_destinations) | Destinations where to deploy apps in. Which namespaces usually. | <pre>list(object({<br>    namespace = string<br>    server    = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_finalizers"></a> [finalizers](#input\_finalizers) | ArgoCD Finalizers to be executed before delete the Project. | `list(string)` | <pre>[<br>  "resources-finalizer.argocd.argoproj.io"<br>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | Project name. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace where ArgoCD is installed. | `string` | `"argocd"` | no |
| <a name="input_namespace_resource_allow_list"></a> [namespace\_resource\_allow\_list](#input\_namespace\_resource\_allow\_list) | If defined deny all namespaced-scoped resources except the defined ones. | <pre>list(object({<br>    group = string<br>    kind  = string<br>  }))</pre> | `null` | no |
| <a name="input_namespace_resource_deny_list"></a> [namespace\_resource\_deny\_list](#input\_namespace\_resource\_deny\_list) | If defined allows all namespaced-scoped resources except the defined ones. | <pre>list(object({<br>    group = string<br>    kind  = string<br>  }))</pre> | `null` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | Project permissions to be applied to one or many groups | <pre>map(object({<br>    description = string<br>    policies = list(object({<br>      resource = optional(string)<br>      action   = string<br>      object   = optional(string)<br>    }))<br>    groups = list(string)<br>  }))</pre> | `null` | no |
| <a name="input_source_repos"></a> [source\_repos](#input\_source\_repos) | Allowed source repos to be used by this Project | `list(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
