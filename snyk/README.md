# snyk

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.7.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.7.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_helm_snyk"></a> [helm\_snyk](#module\_helm\_snyk) | ../helm-release | n/a |
| <a name="module_irsa"></a> [irsa](#module\_irsa) | ../../eks/irsa | n/a |
| <a name="module_namespace"></a> [namespace](#module\_namespace) | ../core/namespace | n/a |

## Resources

| Name | Type |
|------|------|
| [kubernetes_config_map.snyk_monitor_custom_policies](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_secret.provisioned](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [aws_iam_policy_document.role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argocd_app_config"></a> [argocd\_app\_config](#input\_argocd\_app\_config) | ArgoCD Application config. See k8s/argocd/resources/application | `any` | `{}` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Snyk monitor helm chart version to use (https://github.com/snyk/kubernetes-monitor/tree/staging/snyk-monitor). | `string` | `"2.2.1"` | no |
| <a name="input_dockercfg_json"></a> [dockercfg\_json](#input\_dockercfg\_json) | JSON dockercfg used by snyk-monitor to access to quay.io. configure\_namespace must be true | `string` | `""` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Name of the EKS cluster to deploy into. | `string` | n/a | yes |
| <a name="input_enable_istio"></a> [enable\_istio](#input\_enable\_istio) | Enable istio service mesh? configure\_namespace must be true | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Deploy environment ("dev", "prod" or "tools"). | `string` | n/a | yes |
| <a name="input_iam_suffix"></a> [iam\_suffix](#input\_iam\_suffix) | Will be appended to the end of IAM-related resources to help maintain uniqueness in multi-cluster/multi-region setups | `string` | `null` | no |
| <a name="input_integration_ids"></a> [integration\_ids](#input\_integration\_ids) | Integration ID for Snyk monitor, used to identify the integration in the Snyk UI. | `map(string)` | <pre>{<br>  "dev": "e40d394e-3076-45fe-a9bf-e3546270573c",<br>  "prod": "589ae8da-aea8-448c-bbda-b1335cf9a265",<br>  "tools": "589ae8da-aea8-448c-bbda-b1335cf9a265"<br>}</pre> | no |
| <a name="input_manage_via_argocd"></a> [manage\_via\_argocd](#input\_manage\_via\_argocd) | Determines if the release should be managed via ArgoCD. | `bool` | `false` | no |
| <a name="input_service_account_api_token"></a> [service\_account\_api\_token](#input\_service\_account\_api\_token) | API Token which enables Snyk monitor to communicate with the Snyk API. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to AWS resources. | `map(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
