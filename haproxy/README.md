# haproxy

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.7 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~>2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | ~>2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_config_map.haproxy_config](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_deployment.haproxy](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [kubernetes_horizontal_pod_autoscaler.haproxy](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/horizontal_pod_autoscaler) | resource |
| [kubernetes_service.haproxy](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend"></a> [backend](#input\_backend) | Backend service to route traffic into. | `string` | n/a | yes |
| <a name="input_image"></a> [image](#input\_image) | HAProxy container image. | `string` | `"567716553783.dkr.ecr.us-east-1.amazonaws.com/haproxy:2.4.3"` | no |
| <a name="input_limits"></a> [limits](#input\_limits) | HAProxy container resource limits. | `object({ cpu = string, memory = string })` | <pre>{<br>  "cpu": "1000m",<br>  "memory": "1024Mi"<br>}</pre> | no |
| <a name="input_max_replicas"></a> [max\_replicas](#input\_max\_replicas) | Max number of HAProxy pods. | `number` | `8` | no |
| <a name="input_min_replicas"></a> [min\_replicas](#input\_min\_replicas) | Min number of HAProxy pods. | `number` | `2` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the HAProxy installation. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace where we will deploy HAProxy. | `string` | n/a | yes |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | Spin this number of HAProxy pods in the beginning. | `number` | `2` | no |
| <a name="input_requests"></a> [requests](#input\_requests) | HAProxy container resource requests. | `object({ cpu = string, memory = string })` | <pre>{<br>  "cpu": "250m",<br>  "memory": "256Mi"<br>}</pre> | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Timeouts for create/update/delete deployment operations. | `object({ create = string, update = string, delete = string })` | <pre>{<br>  "create": "20m",<br>  "delete": "10m",<br>  "update": "20m"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service"></a> [service](#output\_service) | Name of the HAProxy service. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
