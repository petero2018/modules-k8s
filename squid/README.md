# squid

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.6 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >=1.13.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.7.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >=1.13.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.7.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.service_entry](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_config_map.squid_config](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_deployment.squid](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [kubernetes_horizontal_pod_autoscaler_v2.squid](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/horizontal_pod_autoscaler_v2) | resource |
| [kubernetes_pod_disruption_budget_v1.squid](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod_disruption_budget_v1) | resource |
| [kubernetes_service.squid](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_security_context"></a> [container\_security\_context](#input\_container\_security\_context) | Container-level security context settings. | <pre>object({<br>    add_capabilities  = list(string),<br>    drop_capabilities = list(string),<br>  })</pre> | <pre>{<br>  "add_capabilities": [],<br>  "drop_capabilities": []<br>}</pre> | no |
| <a name="input_denied_cidrs"></a> [denied\_cidrs](#input\_denied\_cidrs) | List of CIDRs with denied access to. | `list(string)` | <pre>[<br>  "192.168.0.0/16",<br>  "172.16.0.0/12",<br>  "10.0.0.0/8"<br>]</pre> | no |
| <a name="input_deploy_arch"></a> [deploy\_arch](#input\_deploy\_arch) | Node architecture to deploy to. Must be either "amd64" or "arm64" | `string` | `"arm64"` | no |
| <a name="input_image"></a> [image](#input\_image) | Squid container image. | `string` | `"ubuntu/squid:5.2-22.04_beta"` | no |
| <a name="input_istio_namespace"></a> [istio\_namespace](#input\_istio\_namespace) | Namespace where we have our Istio mesh compomnents installed. | `string` | `"istio-system"` | no |
| <a name="input_max_replicas"></a> [max\_replicas](#input\_max\_replicas) | Max number of Squid pods. | `number` | `8` | no |
| <a name="input_min_replicas"></a> [min\_replicas](#input\_min\_replicas) | Min number of Squid pods. | `number` | `2` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the Squid installation. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace where we will deploy Squid. | `string` | n/a | yes |
| <a name="input_pod_security_context"></a> [pod\_security\_context](#input\_pod\_security\_context) | Pod security context settings. | <pre>object({<br>    fs_group = number,<br>  })</pre> | <pre>{<br>  "fs_group": 65534<br>}</pre> | no |
| <a name="input_replicas"></a> [replicas](#input\_replicas) | Spin this number of Squid pods in the beginning. | `number` | `2` | no |
| <a name="input_requests"></a> [requests](#input\_requests) | Squid container resource requests. | `object({ cpu = string, memory = string })` | <pre>{<br>  "cpu": "250m",<br>  "memory": "256Mi"<br>}</pre> | no |
| <a name="input_run_as_group"></a> [run\_as\_group](#input\_run\_as\_group) | Defines the group where the container will run, default 0. | `string` | `"0"` | no |
| <a name="input_run_as_non_root"></a> [run\_as\_non\_root](#input\_run\_as\_non\_root) | Needs to be true in order to run the container as a non-root user. | `bool` | `false` | no |
| <a name="input_run_as_user"></a> [run\_as\_user](#input\_run\_as\_user) | Defines the user id that will run the container, default 0 (root). | `string` | `"0"` | no |
| <a name="input_tolerations"></a> [tolerations](#input\_tolerations) | Pod tolerations. | <pre>list(object({<br>    key      = optional(string)<br>    operator = optional(string)<br>    value    = optional(string)<br>    effect   = optional(string)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service"></a> [service](#output\_service) | Name of the Squid service. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
