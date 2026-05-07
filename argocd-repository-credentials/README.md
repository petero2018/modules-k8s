# Repository Credentials

Creates an ArgoCD repository credentials using a Secret.
https://github.com/argoproj/argo-cd/blob/master/docs/operator-manual/argocd-repo-creds.yaml

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >=1.13.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >=1.13.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.repository_credentials](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_annotations"></a> [annotations](#input\_annotations) | Annotations to be applied to K8S resources. | `map(string)` | `{}` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to be applied to K8S resources. | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the repository credentials | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace where ArgoCD is installed. | `string` | `"argocd"` | no |
| <a name="input_password"></a> [password](#input\_password) | If username/password is not specified, must specify ssh\_private\_key. | `string` | `null` | no |
| <a name="input_ssh_private_key"></a> [ssh\_private\_key](#input\_ssh\_private\_key) | If not specified, must specify username/password. | `string` | `null` | no |
| <a name="input_type"></a> [type](#input\_type) | Repository type. Must be: git or helm | `string` | `"git"` | no |
| <a name="input_url"></a> [url](#input\_url) | URL of the repository. | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | If username/password is not specified, must specify ssh\_private\_key. | `string` | `null` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
