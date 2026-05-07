# istio

This module deploys and configures istio on a kubernetes cluster.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |
| <a name="requirement_external"></a> [external](#requirement\_external) | ~>2.1.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.13.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |
| <a name="provider_external"></a> [external](#provider\_external) | ~>2.1.0 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.13.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_istio_base"></a> [istio\_base](#module\_istio\_base) | git@github.com:powise/terraform-modules//k8s/helm-release | helm-release-0.4.1 |
| <a name="module_istio_discovery"></a> [istio\_discovery](#module\_istio\_discovery) | git@github.com:powise/terraform-modules//k8s/helm-release | helm-release-0.4.1 |
| <a name="module_istio_egress"></a> [istio\_egress](#module\_istio\_egress) | git@github.com:powise/terraform-modules//k8s/helm-release | helm-release-0.4.1 |
| <a name="module_namespace"></a> [namespace](#module\_namespace) | git@github.com:powise/terraform-modules//k8s/core/namespace | core-namespace-2.2.3 |

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.filter_preserve_external_request_id](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.log_errors](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [external_external.istio](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_capacity_type_selector"></a> [capacity\_type\_selector](#input\_capacity\_type\_selector) | The key and value used for the nodeSelector for Istio control plane components. | <pre>object({<br>    key   = optional(string, "eks\\.amazonaws\\.com/capacityType")<br>    value = optional(string, "ON_DEMAND")<br>  })</pre> | n/a | yes |
| <a name="input_deploy_arch"></a> [deploy\_arch](#input\_deploy\_arch) | Node architecture to deploy to. Must be either "amd64" or "arm64" | `string` | `"amd64"` | no |
| <a name="input_enable_legacy_fsgroup_injection"></a> [enable\_legacy\_fsgroup\_injection](#input\_enable\_legacy\_fsgroup\_injection) | If true (default), Istiod will set the pod fsGroup to 1337 on injection. This is required for Kubernetes 1.18 and older. | `bool` | `true` | no |
| <a name="input_exclude_outbound_ports"></a> [exclude\_outbound\_ports](#input\_exclude\_outbound\_ports) | Don't capture egress traffic on those ports. | `list(number)` | `[]` | no |
| <a name="input_hold_application"></a> [hold\_application](#input\_hold\_application) | Wait for Envoy to become ready before starting app containers (default behavior, may be overriden per-pod with annotations). | `bool` | `true` | no |
| <a name="input_hub"></a> [hub](#input\_hub) | Container registry hub. | `string` | `null` | no |
| <a name="input_include_ip_ranges"></a> [include\_ip\_ranges](#input\_include\_ip\_ranges) | Capture egress traffic on those IP Ranges (empty list means capture all). | `list(string)` | `[]` | no |
| <a name="input_install_egress_gateway"></a> [install\_egress\_gateway](#input\_install\_egress\_gateway) | Whether to install the egress gateway. | `bool` | `true` | no |
| <a name="input_istio_version"></a> [istio\_version](#input\_istio\_version) | istio version to install. | `string` | n/a | yes |
| <a name="input_preserve_external_request_id"></a> [preserve\_external\_request\_id](#input\_preserve\_external\_request\_id) | Preserve the value of "X-Request-Id" header set on the upstream instead of [re]setting it. | `bool` | `false` | no |
| <a name="input_sidecar_requests"></a> [sidecar\_requests](#input\_sidecar\_requests) | Resource requests of the sidecar proxy container. | `object({ cpu = string, memory = string })` | <pre>{<br>  "cpu": "250m",<br>  "memory": "512Mi"<br>}</pre> | no |
| <a name="input_use_xds_v2_api"></a> [use\_xds\_v2\_api](#input\_use\_xds\_v2\_api) | Use xDS v2 API for Envoy configuration. This is required for older versions of Istio. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_istio_charts_path"></a> [istio\_charts\_path](#output\_istio\_charts\_path) | Local path to install istio charts from |
| <a name="output_istio_namespace"></a> [istio\_namespace](#output\_istio\_namespace) | Namespace we deployed istio into. |
| <a name="output_istio_version"></a> [istio\_version](#output\_istio\_version) | istio chart version we installed in this module |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
