# rbac

This module configures the resources needed for roles such as TerraformRole and CiCd Role to access the cluster.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.11.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.11.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_cluster_role_binding.binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_config_map.aws_auth](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_role_binding.binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_role.worker_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_annotations"></a> [annotations](#input\_annotations) | Annotations to be applied to resources. | `map(string)` | `{}` | no |
| <a name="input_groups"></a> [groups](#input\_groups) | Kubernetes groups to authorize | <pre>list(object({<br>    name      = string<br>    global    = optional(list(string))<br>    namespace = optional(map(list(string)))<br>  }))</pre> | <pre>[<br>  {<br>    "global": [<br>      "view"<br>    ],<br>    "name": "developers"<br>  }<br>]</pre> | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to be applied to resources. | `map(string)` | `{}` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | AWS roles to add to the aws-auth configmap. | <pre>list(object({<br>    role     = string<br>    username = string<br>    groups   = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "groups": [<br>      "developers"<br>    ],<br>    "role": "DevRole",<br>    "username": "dev"<br>  }<br>]</pre> | no |
| <a name="input_worker_role_names"></a> [worker\_role\_names](#input\_worker\_role\_names) | IAM role names for worker node groups (used in aws-auth config map). | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_worker_role_arns"></a> [worker\_role\_arns](#output\_worker\_role\_arns) | IAM role ARNs for worker nodes. |
| <a name="output_worker_role_names"></a> [worker\_role\_names](#output\_worker\_role\_names) | IAM role names for worker nodes. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
