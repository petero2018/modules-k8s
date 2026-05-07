# Karpenter

Karpenter is an open-source node provisioning project built for Kubernetes. Karpenter automatically launches just the right compute resources to handle your cluster's applications. It is designed to let you take full advantage of the cloud with fast and simple compute provisioning for Kubernetes clusters.

For more details checkout [Karpenter](https://karpenter.sh/docs/getting-started/) docs
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_crd_release"></a> [crd\_release](#module\_crd\_release) | ../../helm-release | n/a |
| <a name="module_irsa"></a> [irsa](#module\_irsa) | ../../../eks/irsa | n/a |
| <a name="module_release"></a> [release](#module\_release) | ../../helm-release | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.karpenter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.karpenter_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_role.worker_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argocd_app_config"></a> [argocd\_app\_config](#input\_argocd\_app\_config) | ArgoCD Application config. See k8s/argocd/resources/application | `any` | `{}` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | The version of argocd to install. | `string` | n/a | yes |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if it does not yet exist. | `bool` | `false` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Name of the EKS cluster to deploy into. | `string` | n/a | yes |
| <a name="input_eks_cluster_endpoint"></a> [eks\_cluster\_endpoint](#input\_eks\_cluster\_endpoint) | EKS cluster endpoint. | `string` | n/a | yes |
| <a name="input_helm_config"></a> [helm\_config](#input\_helm\_config) | Helm provider config for argocd | `any` | `{}` | no |
| <a name="input_iam_suffix"></a> [iam\_suffix](#input\_iam\_suffix) | Will be appended to the end of IAM-related resources to help maintain uniqueness in multi-cluster/multi-region setups | `string` | `""` | no |
| <a name="input_install_crds"></a> [install\_crds](#input\_install\_crds) | CRDs appropriate for the current version will be managed using the separate Helm chart. See https://karpenter.sh/v0.33/troubleshooting/#helm-error-when-installing-the-karpenter-crd-chart if you encounter errors. | `bool` | `true` | no |
| <a name="input_manage_via_argocd"></a> [manage\_via\_argocd](#input\_manage\_via\_argocd) | Determines if the release should be managed via ArgoCD. | `bool` | `false` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to install the components in. | `string` | `"kube-system"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to AWS resources. | `map(string)` | n/a | yes |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Time in seconds to wait for release installation. | `number` | `300` | no |
| <a name="input_worker_role_name"></a> [worker\_role\_name](#input\_worker\_role\_name) | EKS Cluster worker role name. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_profile_arn"></a> [instance\_profile\_arn](#output\_instance\_profile\_arn) | Karpenter Instance Profile ARN |
| <a name="output_instance_profile_name"></a> [instance\_profile\_name](#output\_instance\_profile\_name) | Karpenter Instance Profile Name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
