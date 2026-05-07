# proxy

This module deploys and configures ha-proxy on a kubernetes cluster.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.6 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.7.1 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~>3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.7.1 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~>3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_config_map.haproxy_config](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_deployment.haproxy](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [kubernetes_horizontal_pod_autoscaler_v2.haproxy](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/horizontal_pod_autoscaler_v2) | resource |
| [kubernetes_pod_disruption_budget_v1.haproxy](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod_disruption_budget_v1) | resource |
| [kubernetes_secret.haproxy](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_service.haproxy](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |
| [tls_private_key.haproxy](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_self_signed_cert.haproxy](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend"></a> [backend](#input\_backend) | Backend service to route traffic into. | `string` | `"istio-ingressgateway:443"` | no |
| <a name="input_block_indexing"></a> [block\_indexing](#input\_block\_indexing) | Block indexing from search engine bots, by adding the X-Robots-Tag header to all responses. | `bool` | `false` | no |
| <a name="input_deploy_arch"></a> [deploy\_arch](#input\_deploy\_arch) | Node architecture to deploy to. Must be either "amd64" or "arm64" | `string` | `"amd64"` | no |
| <a name="input_haproxy_config"></a> [haproxy\_config](#input\_haproxy\_config) | Customizable HAProxy settings. | <pre>object({<br>    tune_bufsize = number<br>  })</pre> | <pre>{<br>  "tune_bufsize": 16384<br>}</pre> | no |
| <a name="input_max_replicas"></a> [max\_replicas](#input\_max\_replicas) | Max number of HAProxy pods. | `number` | `8` | no |
| <a name="input_min_replicas"></a> [min\_replicas](#input\_min\_replicas) | Min number of HAProxy pods. | `number` | `2` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the HAProxy installation. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace where we will deploy the proxy. | `string` | n/a | yes |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | Spin this number of HAProxy pods in the beginning. | `number` | `2` | no |
| <a name="input_strip_baggage"></a> [strip\_baggage](#input\_strip\_baggage) | Strip baggage header from incoming requests, to prevent baggage injection from external calls. | `bool` | `true` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Timeouts for create/update/delete deployment operations. | `object({ create = string, update = string, delete = string })` | <pre>{<br>  "create": "20m",<br>  "delete": "10m",<br>  "update": "20m"<br>}</pre> | no |
| <a name="input_tolerations"></a> [tolerations](#input\_tolerations) | Pod tolerations. | <pre>list(object({<br>    key      = optional(string)<br>    operator = optional(string)<br>    value    = optional(string)<br>    effect   = optional(string)<br>  }))</pre> | `[]` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
