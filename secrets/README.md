# secrets

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.6 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_secret.main](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to identify resource ownership. | `map(string)` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace to deploy secrets into. | `string` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | A map of secret objects (name => data) to provision. | `map(map(string))` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fields"></a> [fields](#output\_fields) | Secret data fields referenced in { secret\_name => [field1, field2 ... fieldN] } form. |
| <a name="output_names"></a> [names](#output\_names) | Names of the secrets provisioned. |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | Namespace where secrets were provisioned. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
