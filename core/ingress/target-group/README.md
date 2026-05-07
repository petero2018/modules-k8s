# target-group ingress

Attach Kubernetes service ingress to the specified AWS load balancer target group.

:bulb: Implemented using [TargetGroupBinding](https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.2/guide/targetgroupbinding/targetgroupbinding/) custom resource.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.7 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.13.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.13.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.target_group_binding](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ingress_name"></a> [ingress\_name](#input\_ingress\_name) | Free-form name of the ingress configuration. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to install Kubernetes TargetGroupBinding custom resource. | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the Kubernetes service to use. | `string` | n/a | yes |
| <a name="input_service_port"></a> [service\_port](#input\_service\_port) | Number of port configured on the Kubernetes service. | `number` | n/a | yes |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | ARN of the AWS lb target group to attach this ingress. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_target_group_arn"></a> [target\_group\_arn](#output\_target\_group\_arn) | AWS load balancer target group ARN. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
