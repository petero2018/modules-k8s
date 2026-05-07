# nginx ingress

This module configures a [nginx ingress](https://kubernetes.github.io/ingress-nginx/) deployment configured to get the traffic from an ALB Target Group.
This is useful to share ALBs between different ingresses and ensure the load balancer is properly configured among powise standards (see `proxyv3`)

## Dependencies
This module creates a `TargetGroupBinding` for associate the ALB with the NGINX ingress.
In order to this to work the `aws-load-balancer-controller` must be installed on the cluster.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.16.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.16.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_release"></a> [release](#module\_release) | ../../../helm-release | n/a |

## Resources

| Name | Type |
|------|------|
| [kubernetes_manifest.target_group_binding_http](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.target_group_binding_https](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argocd_app_config"></a> [argocd\_app\_config](#input\_argocd\_app\_config) | ArgoCD Application config. See k8s/argocd/resources/application | `any` | `{}` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | The version of aws load balancer controller chart to install. | `string` | n/a | yes |
| <a name="input_helm_config"></a> [helm\_config](#input\_helm\_config) | Helm provider config for aws load balancer controller | `any` | `{}` | no |
| <a name="input_http_target_group_arn"></a> [http\_target\_group\_arn](#input\_http\_target\_group\_arn) | Bind ingress service to an existing HTTP target groups ARN. | `string` | `null` | no |
| <a name="input_ingress_class_name"></a> [ingress\_class\_name](#input\_ingress\_class\_name) | Name of the ingress class to create. By default the same as name | `string` | `null` | no |
| <a name="input_ingress_max_replicas"></a> [ingress\_max\_replicas](#input\_ingress\_max\_replicas) | Maximum number of ingress replicas. | `number` | `6` | no |
| <a name="input_ingress_min_replicas"></a> [ingress\_min\_replicas](#input\_ingress\_min\_replicas) | Minimum number of ingress replicas. | `number` | `2` | no |
| <a name="input_ingress_publish_service"></a> [ingress\_publish\_service](#input\_ingress\_publish\_service) | To announce the ingress service ip to ingress resources so that external-dns can collect them and create DNS entries. | `bool` | `false` | no |
| <a name="input_ingress_service_annotations"></a> [ingress\_service\_annotations](#input\_ingress\_service\_annotations) | Annotations to be applied to ingress service. (mainly to setup LoadBalancer if service type is LoadBalancer). | `map(string)` | `{}` | no |
| <a name="input_ingress_service_type"></a> [ingress\_service\_type](#input\_ingress\_service\_type) | Istio ingress service type to create on the cluster. | `string` | `"ClusterIP"` | no |
| <a name="input_manage_via_argocd"></a> [manage\_via\_argocd](#input\_manage\_via\_argocd) | Determines if the release should be managed via ArgoCD. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the nginx ingress. | `string` | `"nginx"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to install the components in. | `string` | `"kube-system"` | no |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | Bind ingress service to an existing target groups ARN. | `string` | n/a | yes |
| <a name="input_target_group_type"></a> [target\_group\_type](#input\_target\_group\_type) | Target type for the target group. | `string` | `"ip"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
