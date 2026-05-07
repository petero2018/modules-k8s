# generic ingress

This module configures a kubernetes native ingress for a kubernetes cluster.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >=2.8.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >=2.8.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_certificate"></a> [certificate](#module\_certificate) | jpamies/certificate/aws | ~>1.0 |
| <a name="module_ips"></a> [ips](#module\_ips) | ../../../../common/ips/ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [kubernetes_ingress_v1.alb](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource |
| [kubernetes_service.nlb](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |
| [aws_eks_cluster.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_route53_zone.ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_subnets.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_subnets.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | ACM certificate ARN to use on the load balancer (if not creatng certificate). | `string` | `null` | no |
| <a name="input_alb_config"></a> [alb\_config](#input\_alb\_config) | ALB configuration. Makes sense to configure only for "powise-alb" ingress type. | <pre>object({<br>    backend_protocol     = string<br>    healthcheck_protocol = string<br>    healthcheck_path     = string<br>  })</pre> | <pre>{<br>  "backend_protocol": "HTTPS",<br>  "healthcheck_path": "/health",<br>  "healthcheck_protocol": "HTTPS"<br>}</pre> | no |
| <a name="input_backend_service_name"></a> [backend\_service\_name](#input\_backend\_service\_name) | Name of the backend service to use. | `string` | `null` | no |
| <a name="input_backend_service_ports"></a> [backend\_service\_ports](#input\_backend\_service\_ports) | Ports configured on the backend service. | <pre>object({<br>    http  = number<br>    https = number<br>  })</pre> | <pre>{<br>  "http": 80,<br>  "https": 443<br>}</pre> | no |
| <a name="input_cidr_blocks"></a> [cidr\_blocks](#input\_cidr\_blocks) | CIDR blocks to open the load balancer to. | `list(string)` | `null` | no |
| <a name="input_dns_zone"></a> [dns\_zone](#input\_dns\_zone) | DNS zone used for certificate validation (if certificate is created). | `string` | `null` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Name of the EKS cluster to deploy into. | `string` | n/a | yes |
| <a name="input_environment_type"></a> [environment\_type](#input\_environment\_type) | Is this a part of normal or ephemeral environment? | `string` | `"normal"` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Hostname of the ingress. | `string` | n/a | yes |
| <a name="input_ingress_name"></a> [ingress\_name](#input\_ingress\_name) | Name of the environment/namespace to serve with this ingress. | `string` | n/a | yes |
| <a name="input_ingress_purpose"></a> [ingress\_purpose](#input\_ingress\_purpose) | Purpose of the ingress. | `string` | n/a | yes |
| <a name="input_ingress_type"></a> [ingress\_type](#input\_ingress\_type) | Type of the ingress resource to use ("powise-alb" or "powise-nlb"). Default is "powise-alb". | `string` | `"powise-alb"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to install kubernetes resources. | `string` | `"istio-system"` | no |
| <a name="input_open_http"></a> [open\_http](#input\_open\_http) | Whether to open the HTTP port (80). | `bool` | `true` | no |
| <a name="input_private_subnet_tags"></a> [private\_subnet\_tags](#input\_private\_subnet\_tags) | Discover private subnets by these tags (for ingress/ALB). | `map(string)` | n/a | yes |
| <a name="input_public_subnet_tags"></a> [public\_subnet\_tags](#input\_public\_subnet\_tags) | Discover public subnets by these tags (for ingress/ALB). | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acm_certificate_arn"></a> [acm\_certificate\_arn](#output\_acm\_certificate\_arn) | ACM certificate ARN used on the load balancer. |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | LoadBalancer address, in case of NLB pointing to the set of stable IPs (e.g. for use in external plan with blue/green proxies). |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
