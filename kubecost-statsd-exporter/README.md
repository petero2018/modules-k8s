# kubecost-statsd-exporter

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_deployment"></a> [deployment](#module\_deployment) | git@github.com:powise/terraform-modules//k8s/simple-deployment | simple-deployment-2.10.5 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_image_tag"></a> [app\_image\_tag](#input\_app\_image\_tag) | Image tag for kafdrop | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region name to use on the name of the IAM role | `string` | `""` | no |
| <a name="input_backend_port"></a> [backend\_port](#input\_backend\_port) | App backend port for checks | `string` | `"8888"` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Name of the EKS cluster. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment to deploy to. | `string` | n/a | yes |
| <a name="input_kubecost_url"></a> [kubecost\_url](#input\_kubecost\_url) | kubecost analyzer endpoint internal url | `string` | `"kubecost-cost-analyzer.kubecost:9090"` | no |
| <a name="input_label"></a> [label](#input\_label) | select the label to which group costs by (app or team) | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to deploy to. | `string` | n/a | yes |
| <a name="input_statsd_host"></a> [statsd\_host](#input\_statsd\_host) | StatsD sidecar host | `string` | `"localhost"` | no |
| <a name="input_statsd_port"></a> [statsd\_port](#input\_statsd\_port) | StatsD sidecar port | `string` | `"9125"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to resources. | `map(string)` | <pre>{<br>  "impact": "low",<br>  "service": "kubecost-statsd-exporter",<br>  "team": "product-infrastructure-team"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
