# FileBeat

Install [FileBeat](https://github.com/elastic/helm-charts/tree/main/filebeat) helm chart.
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
| <a name="module_filebeat"></a> [filebeat](#module\_filebeat) | git@github.com:powise/terraform-modules//k8s/helm-release | helm-release-0.3.1 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | The version of filebeat helm to install. | `string` | n/a | yes |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if it does not yet exist. | `bool` | `true` | no |
| <a name="input_drop_fields"></a> [drop\_fields](#input\_drop\_fields) | List of fields to drop from processing. | `list(string)` | `[]` | no |
| <a name="input_drop_services"></a> [drop\_services](#input\_drop\_services) | Drop events coming from these specific services (Kubernetes app label). | `list(string)` | `[]` | no |
| <a name="input_helm_config"></a> [helm\_config](#input\_helm\_config) | Helm provider config for filebeat | `any` | `{}` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to install the components in. | `string` | `"filebeat"` | no |
| <a name="input_template_file"></a> [template\_file](#input\_template\_file) | The template file to use for filebeat. If no template file is specified it will use the default one. | `string` | `""` | no |
| <a name="input_template_values"></a> [template\_values](#input\_template\_values) | The values to use for resolve the template. | `map(string)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Time in seconds to wait for release installation. | `number` | `600` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
