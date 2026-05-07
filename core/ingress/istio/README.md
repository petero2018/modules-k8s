# istio ingress

This module configures an istio ingress deployment for a kubernetes cluster.

## Breaking changes

### Migrating to the new `target_groups` variable

Original PR: https://github.com/powise/terraform-modules/pull/1365

Migration is possible without recreating the target group bindings resources if you follow these steps:

* Remove these input variables:
  * `http_port`
  * `https_port`
  * `target_group_arn`
  * `http_target_group_arn`
  * `tcp_target_group_arn`
* Use the new `target_groups` input variable
  * If you only use HTTPS with port 443 you don't need to define the port
  * The dict keys will need to be named after the existing `TargetGroupBindings`
* Edit the state with `terragrunt state mv` to move the old target group binding resources to the new one

If you don't want to edit the state it's also possible to recreate the target group bindings but it's unknown whether this would break anything, at least temporarily.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |
| <a name="requirement_external"></a> [external](#requirement\_external) | >= 2.1.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.19.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |
| <a name="provider_external"></a> [external](#provider\_external) | >= 2.1.0 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.19.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_istio_ingress"></a> [istio\_ingress](#module\_istio\_ingress) | git@github.com:powise/terraform-modules//k8s/helm-release | helm-release-0.4.1 |

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.target_group_binding](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [random_string.name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_lb.istio_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [external_external.istio](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | ACM certificate ARN to use on the load balancer (relevant only for LoadBalancer service type). | `string` | `null` | no |
| <a name="input_anti_affinity"></a> [anti\_affinity](#input\_anti\_affinity) | Pod anti affinity settings. | <pre>object({<br>    per_az = optional(object({<br>      enable = optional(bool, true)<br>      hard   = optional(bool, false) # This should never be on unless you don't plan for more than 3 pods<br>    }), {})<br>    per_host = optional(object({<br>      enable = optional(bool, true)<br>      hard   = optional(bool, false) # This will require 1 host per pod, which can be a lot depending on the scale<br>    }), {})<br>  })</pre> | `{}` | no |
| <a name="input_aws_iam_role_arn"></a> [aws\_iam\_role\_arn](#input\_aws\_iam\_role\_arn) | The AWS IAM role to associate with the ingressgateway service account (requires OIDC / IRSA to be setup on the cluster) | `string` | `null` | no |
| <a name="input_capacity_type_selector"></a> [capacity\_type\_selector](#input\_capacity\_type\_selector) | The key and value used for the nodeSelector for Istio control plane components. | <pre>object({<br>    key   = optional(string, "eks\\.amazonaws\\.com/capacityType")<br>    value = optional(string, "ON_DEMAND")<br>  })</pre> | n/a | yes |
| <a name="input_deploy_arch"></a> [deploy\_arch](#input\_deploy\_arch) | Node architecture to deploy to. Must be either "amd64" or "arm64" | `string` | `"amd64"` | no |
| <a name="input_eks_auto_mode"></a> [eks\_auto\_mode](#input\_eks\_auto\_mode) | Use EKS Auto Mode CRDs. | `bool` | `false` | no |
| <a name="input_enable_csi"></a> [enable\_csi](#input\_enable\_csi) | Setting this to true will make the Istio gateway mount its ingressgateway-certs directory from a SecretProviderClass called ingressgateway-certs, using the secrets-store.csi driver. An appropriate IRSA setup (using aws\_iam\_role\_arn) is required to use this properly. | `bool` | `false` | no |
| <a name="input_extra_ports"></a> [extra\_ports](#input\_extra\_ports) | List of extra ports that the ingress gateway pods will listen on. | <pre>list(object({<br>    name       = string<br>    port       = number<br>    targetPort = number<br>    protocol   = string<br>  }))</pre> | `[]` | no |
| <a name="input_hub"></a> [hub](#input\_hub) | Container registry hub. | `string` | `null` | no |
| <a name="input_ingress_labels"></a> [ingress\_labels](#input\_ingress\_labels) | Ingress labels to use on the Gateway selector. | `map(string)` | <pre>{<br>  "istio": "ingressgateway"<br>}</pre> | no |
| <a name="input_ingress_service_type"></a> [ingress\_service\_type](#input\_ingress\_service\_type) | Istio ingress service type to create on the cluster. | `string` | `"ClusterIP"` | no |
| <a name="input_istio_charts_path"></a> [istio\_charts\_path](#input\_istio\_charts\_path) | Local path to install istio ingress gateway chart from (will try to download, if null) | `string` | `null` | no |
| <a name="input_istio_version"></a> [istio\_version](#input\_istio\_version) | istio version to install. | `string` | n/a | yes |
| <a name="input_keep_source_ip"></a> [keep\_source\_ip](#input\_keep\_source\_ip) | Keep the source IP to pass on the request for istio ingress gateway (relevant only for LoadBalancer service type). | `bool` | `false` | no |
| <a name="input_load_balancer_healthcheck_port"></a> [load\_balancer\_healthcheck\_port](#input\_load\_balancer\_healthcheck\_port) | Port to be used for healthcheck by the load balancer associated with istio's ingress gateway (relevant only for LoadBalancer service type). | `string` | `"traffic-port"` | no |
| <a name="input_load_balancer_scheme"></a> [load\_balancer\_scheme](#input\_load\_balancer\_scheme) | Load balancer scheme. Specifies whether the NLB will be "internet-facing" or "internal". | `string` | `"internal"` | no |
| <a name="input_max_pods"></a> [max\_pods](#input\_max\_pods) | Maximum number of pods. | `number` | `32` | no |
| <a name="input_min_pods"></a> [min\_pods](#input\_min\_pods) | Minimum number of pods. | `number` | `2` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the istio ingress gateway chart release. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to install istio ingress gateway chart. | `string` | n/a | yes |
| <a name="input_num_trusted_proxies"></a> [num\_trusted\_proxies](#input\_num\_trusted\_proxies) | Number of trusted reverse proxies in front of the istio ingress gateway, to fetch source IP from the X-Forwarded-For header. | `number` | `0` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the istio ingress gateway service. | `string` | `"istio-ingressgateway"` | no |
| <a name="input_target_groups"></a> [target\_groups](#input\_target\_groups) | Map of target groups: name => (target group ARN, TCP port). | <pre>map(object({<br>    arn  = string<br>    port = optional(number, 443)<br>  }))</pre> | `{}` | no |
| <a name="input_termination_drain_duration"></a> [termination\_drain\_duration](#input\_termination\_drain\_duration) | Termination drain duration in seconds. By default it is 30 seconds to match the default termination grace period set on the pods. | `string` | `"30"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | LoadBalancer DNS name. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
