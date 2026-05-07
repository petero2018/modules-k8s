# Wait Resource status

This module waits until the k8s resource gets to the desired status
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=3.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >=3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=3.0 |
| <a name="provider_null"></a> [null](#provider\_null) | >=3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.wait](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_eks_cluster.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | EKS cluster name, needed to wait resource creation. | `string` | n/a | yes |
| <a name="input_error_message"></a> [error\_message](#input\_error\_message) | Error message to show when the wait times out. | `string` | n/a | yes |
| <a name="input_expected_value"></a> [expected\_value](#input\_expected\_value) | Expected value to look on the json resource to validate it. | `string` | n/a | yes |
| <a name="input_json_path"></a> [json\_path](#input\_json\_path) | JSON Path to look for in the resource | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the resource to wait. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace where the resource to wait is in. | `string` | n/a | yes |
| <a name="input_resource"></a> [resource](#input\_resource) | Resource kind to look. | `string` | n/a | yes |
| <a name="input_step_time"></a> [step\_time](#input\_step\_time) | Time to wait between checks. | `number` | `5` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Timeout of the wait. | `number` | `60` | no |
| <a name="input_wait_trigger"></a> [wait\_trigger](#input\_wait\_trigger) | String to trigger resource wait, usually the resource body. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
