# namespace

This module deploys and configures a namespace on a kubernetes cluster.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.7.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.7.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_namespace.core](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_role.group_aux](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role) | resource |
| [kubernetes_role.user_aux](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role) | resource |
| [kubernetes_role_binding.cicd_core](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.group_aux](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.group_core](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.user_aux](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_role_binding.user_core](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_secret.common_image_pull](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [aws_ssm_parameter.common_image_pull_auth](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_common_credentials"></a> [enable\_common\_credentials](#input\_enable\_common\_credentials) | Make common [image pull] credentials available as a Kubernetes secret. | `bool` | `true` | no |
| <a name="input_enable_istio"></a> [enable\_istio](#input\_enable\_istio) | Enable istio service mesh? (sets "istio-injection" label) | `bool` | `false` | no |
| <a name="input_external_registry_auths"></a> [external\_registry\_auths](#input\_external\_registry\_auths) | Map of <external (non-ECR) registry>:<ssm secret key with registry auth> form to be included in common [image pull] credentials. | `map(string)` | `{}` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to apply to the kubernetes namespace. | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the namespace. | `string` | n/a | yes |
| <a name="input_namespace_type"></a> [namespace\_type](#input\_namespace\_type) | Is this namespace normal, ephemeral, or ... ? | `string` | `"normal"` | no |
| <a name="input_rbac_groups"></a> [rbac\_groups](#input\_rbac\_groups) | List of groups allowed to enumerate resources in this namespace. | `list(string)` | n/a | yes |
| <a name="input_rbac_groups_readonly"></a> [rbac\_groups\_readonly](#input\_rbac\_groups\_readonly) | Are RBAC groups limited to read-only actions only? | `bool` | n/a | yes |
| <a name="input_rbac_users"></a> [rbac\_users](#input\_rbac\_users) | List of users allowed to enumerate resources in this namespace. | `list(string)` | n/a | yes |
| <a name="input_rbac_users_readonly"></a> [rbac\_users\_readonly](#input\_rbac\_users\_readonly) | Are RBAC users limited to read-only actions only? | `bool` | n/a | yes |
| <a name="input_registry_cred_helpers"></a> [registry\_cred\_helpers](#input\_registry\_cred\_helpers) | Configure following helpers for the registries specified. | `map(string)` | <pre>{<br>  "495154853931.dkr.ecr.us-east-1.amazonaws.com": "ecr-login",<br>  "567716553783.dkr.ecr.us-east-1.amazonaws.com": "ecr-login",<br>  "695900824579.dkr.ecr.us-east-1.amazonaws.com": "ecr-login",<br>  "public.ecr.aws": "ecr-login"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_namespace"></a> [namespace](#output\_namespace) | Name of the provisioned namespace. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
