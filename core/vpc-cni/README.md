# Enables VPC CNI

See doc on: https://docs.aws.amazon.com/eks/latest/userguide/pod-networking.html
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~>3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |
| <a name="provider_null"></a> [null](#provider\_null) | ~>3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_vpc_cni"></a> [aws\_vpc\_cni](#module\_aws\_vpc\_cni) | git@github.com:powise/terraform-modules//k8s/helm-release | helm-release-0.3.1 |

## Resources

| Name | Type |
|------|------|
| [aws_eks_addon.vpc_cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [null_resource.drain_nodes_from_cluster](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.import_aws_vpc_cni_plugin](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_eks_cluster.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_configuration_values"></a> [configuration\_values](#input\_configuration\_values) | Custom add-on configuration. | `string` | `null` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Name of the EKS cluster to deploy into. | `string` | n/a | yes |
| <a name="input_enable_security_group_policies"></a> [enable\_security\_group\_policies](#input\_enable\_security\_group\_policies) | Enable security group policies (set "true" to support security groups for pods). | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to resources. | `map(string)` | n/a | yes |
| <a name="input_vpc_cni_chart_version"></a> [vpc\_cni\_chart\_version](#input\_vpc\_cni\_chart\_version) | "VPC CNI" EKS addon helm chart version. | `string` | `"1.1.10"` | no |
| <a name="input_vpc_cni_version"></a> [vpc\_cni\_version](#input\_vpc\_cni\_version) | "VPC CNI" EKS addon version. | `string` | `"v1.16.4-eksbuild.2"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
