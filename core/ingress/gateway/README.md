# istio ingress

This module configures an istio ingress deployment for a kubernetes cluster.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.6 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.13.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.7.1 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~>3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.13.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.7.1 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~>3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.authorization_policy](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.gzip_envoy_filter](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.ingressgateway](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_secret.ingressgateway](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [tls_private_key.ingressgateway](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_self_signed_cert.ingressgateway](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_gzip"></a> [enable\_gzip](#input\_enable\_gzip) | Enable gzip compression for the ingress gateway. | `bool` | `false` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Hostname of the ingress. | `string` | n/a | yes |
| <a name="input_ingress_labels"></a> [ingress\_labels](#input\_ingress\_labels) | Ingress labels to use on the Gateway selector. | `map(string)` | <pre>{<br>  "istio": "ingressgateway"<br>}</pre> | no |
| <a name="input_ingress_restrictions"></a> [ingress\_restrictions](#input\_ingress\_restrictions) | Ingress restrictions to allow only certain CIDR blocks to call specific hostnames. | <pre>object({<br>    allow_rules = list(object({<br>      type        = string,<br>      cidr_blocks = list(string),<br>      hostnames   = list(string),<br>    })),<br>    public_hostnames = list(string),<br>  })</pre> | <pre>{<br>  "allow_rules": [],<br>  "public_hostnames": []<br>}</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the istio ingress gateway custom resource. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to provision gateway custom resource. | `string` | n/a | yes |
| <a name="input_tls_mode"></a> [tls\_mode](#input\_tls\_mode) | TLS mode for the gateway. | `string` | `"SIMPLE"` | no |
| <a name="input_tls_secret_namespace"></a> [tls\_secret\_namespace](#input\_tls\_secret\_namespace) | Namespace to provision TLS secrets for the gateway. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gateway_name"></a> [gateway\_name](#output\_gateway\_name) | Name of the istio ingress gateway kubernetes resource. |
| <a name="output_gateway_namespace"></a> [gateway\_namespace](#output\_gateway\_namespace) | Namespace of the istio ingress gateway kubernetes resource. |
| <a name="output_gateway_reference"></a> [gateway\_reference](#output\_gateway\_reference) | Istio gateway reference in a form of <namespace>/<gateway>. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
