# velero

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_irsa"></a> [irsa](#module\_irsa) | git@github.com:powise/terraform-modules//eks/irsa | eks-irsa-1.2.1 |
| <a name="module_velero"></a> [velero](#module\_velero) | git@github.com:powise/terraform-modules//k8s/helm-release | helm-release-0.4.1 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.velero_backups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region name. | `string` | n/a | yes |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | The version of velero helm to install. | `string` | n/a | yes |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if it does not yet exist. | `bool` | `true` | no |
| <a name="input_deploy_arch"></a> [deploy\_arch](#input\_deploy\_arch) | Node architecture to deploy to. Must be either "amd64" or "arm64" | `string` | `"arm64"` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Name of the EKS cluster to deploy into. | `string` | n/a | yes |
| <a name="input_features"></a> [features](#input\_features) | A list of Velero features to enable. See https://velero.io/docs/main/customize-installation/ for more information. | `list(string)` | <pre>[<br>  "EnableCSI"<br>]</pre> | no |
| <a name="input_helm_config"></a> [helm\_config](#input\_helm\_config) | Helm provider config for velero | `any` | `{}` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to install the components in. | `string` | `"velero"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to AWS resources. | `map(string)` | n/a | yes |
| <a name="input_template_file"></a> [template\_file](#input\_template\_file) | The template file to use for filebeat. If no template file is specified it will use the default one. | `string` | `""` | no |
| <a name="input_template_values"></a> [template\_values](#input\_template\_values) | The values to use for resolve the template. | `map(string)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Time in seconds to wait for release installation. | `number` | `600` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
