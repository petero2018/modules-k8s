# flagger-metrictemplate

This module creates a MetricTemplate for flagger and the flagger module should be installed first for it to work.

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
| [kubectl_manifest.metric_template](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address"></a> [address](#input\_address) | Address of where the metrics are retrieved (e.g.: "https://api.datadoghq.com" or "http://prometheus.istio-system:9090"). Assumes "https://api.datadoghq.com" by default. | `string` | `"https://api.datadoghq.com"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the metric template. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace to install the metric template. | `string` | `"flagger"` | no |
| <a name="input_query"></a> [query](#input\_query) | Metric query used for the canary deployment. | `string` | n/a | yes |
| <a name="input_secret_name"></a> [secret\_name](#input\_secret\_name) | Secret name of the credentials to access the metrics. Default is "datadog". | `string` | `"datadog"` | no |
| <a name="input_type"></a> [type](#input\_type) | Type of the metric template (e.g.: "datadog" or "prometheus"). Assumes "datadog" by default. | `string` | `"datadog"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
