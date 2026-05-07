# goldilocks

Install [goldilocks](https://goldilocks.docs.fairwinds.com) helm chart with a virtual pod autoscaler in recommendation mode (it's a [requirement](https://goldilocks.docs.fairwinds.com/installation/#installation-2)).

After installing the module, you will need to add the label `goldilocks.fairwinds.com/enabled=true` to the namespaces you want `goldilocks` to analyse.

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
| <a name="module_goldilocks"></a> [goldilocks](#module\_goldilocks) | ../helm-release | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argocd_app_config"></a> [argocd\_app\_config](#input\_argocd\_app\_config) | ArgoCD Application config. See k8s/argocd/resources/application | `any` | `{}` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | The version of goldilocks to install. | `string` | n/a | yes |
| <a name="input_controller_limits"></a> [controller\_limits](#input\_controller\_limits) | The limits for the goldilocks controller deployment. | `object({ cpu = string, memory = string })` | <pre>{<br>  "cpu": "50m",<br>  "memory": "64Mi"<br>}</pre> | no |
| <a name="input_controller_requests"></a> [controller\_requests](#input\_controller\_requests) | The requests for the goldilocks controller deployment. | `object({ cpu = string, memory = string })` | <pre>{<br>  "cpu": "50m",<br>  "memory": "64Mi"<br>}</pre> | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if it does not yet exist. | `bool` | `false` | no |
| <a name="input_dashboard_limits"></a> [dashboard\_limits](#input\_dashboard\_limits) | The limits for the goldilocks dashboard deployment. | `object({ cpu = string, memory = string })` | <pre>{<br>  "cpu": "50m",<br>  "memory": "64Mi"<br>}</pre> | no |
| <a name="input_dashboard_requests"></a> [dashboard\_requests](#input\_dashboard\_requests) | The requests for the goldilocks dashboard deployment. | `object({ cpu = string, memory = string })` | <pre>{<br>  "cpu": "50m",<br>  "memory": "64Mi"<br>}</pre> | no |
| <a name="input_ingress_class"></a> [ingress\_class](#input\_ingress\_class) | Ingress class to use. | `string` | `""` | no |
| <a name="input_ingress_host"></a> [ingress\_host](#input\_ingress\_host) | Ingress host to use. | `string` | `""` | no |
| <a name="input_manage_via_argocd"></a> [manage\_via\_argocd](#input\_manage\_via\_argocd) | Determines if the release should be managed via ArgoCD. | `bool` | `false` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to install the components in. | `string` | n/a | yes |
| <a name="input_prometheus_url"></a> [prometheus\_url](#input\_prometheus\_url) | The URL of the Prometheus instance to use (e.g. `http://prometheus.istio-system:9090`). VPA does not require the use of prometheus, but it is supported. The use of prometheus may provide more accurate results. | `string` | `""` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
