# hpa

### Standalone, drop-in Horizontal Pod Autoscaler.

Used to provide HPA for resources that do not have it on their own.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.20.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_horizontal_pod_autoscaler_v2.standalone](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/horizontal_pod_autoscaler_v2) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hpa_name"></a> [hpa\_name](#input\_hpa\_name) | Name of the HorizontalPodAutoscaler object provisioned. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace where we place HorizontalPodAutoscaler. | `string` | n/a | yes |
| <a name="input_scaling"></a> [scaling](#input\_scaling) | Scaling behavior config. | <pre>object({<br>    min_replicas   = number<br>    max_replicas   = number<br>    resource_name  = string<br>    utilization    = number<br>    scale_up_pods  = optional(number),<br>    window_seconds = optional(number)<br>    period_seconds = optional(number)<br>  })</pre> | n/a | yes |
| <a name="input_target"></a> [target](#input\_target) | Autoscaling target settings. | <pre>object({<br>    api_version = optional(string)<br>    kind        = string<br>    name        = string<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
