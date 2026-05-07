# security-group-policy

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.7 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.7.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.7.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_manifest.security_group_policy](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_match_expressions"></a> [match\_expressions](#input\_match\_expressions) | The match expressions for the security group policy. | <pre>list(object({<br>    key      = string,<br>    operator = string,<br>    values   = list(string),<br>  }))</pre> | n/a | yes |
| <a name="input_match_labels"></a> [match\_labels](#input\_match\_labels) | The match labels for the security group policy. | `map(string)` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of security group policy. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace of security group policy. | `string` | n/a | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | The security group ids for the security group policy. | `list(string)` | n/a | yes |
| <a name="input_selector"></a> [selector](#input\_selector) | The selector for security group policy. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name"></a> [name](#output\_name) | The name of the resource. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
