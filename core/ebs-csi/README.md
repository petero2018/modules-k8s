# EBS CSI

The Amazon Elastic Block Store (Amazon EBS) Container Storage Interface (CSI) driver allows Amazon Elastic Kubernetes Service (Amazon EKS) clusters to manage the lifecycle of Amazon EBS volumes for persistent volumes.
- https://docs.aws.amazon.com/eks/latest/userguide/ebs-csi.html
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
| <a name="module_ebs_csi_irsa"></a> [ebs\_csi\_irsa](#module\_ebs\_csi\_irsa) | ../../../eks/irsa | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_eks_addon.ebs_csi_driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [null_resource.delete_default](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_eks_cluster.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [aws_iam_policy_document.kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Region name where the cluster is running. This is used for IAM roles naming. | `string` | `""` | no |
| <a name="input_configuration_values"></a> [configuration\_values](#input\_configuration\_values) | Custom add-on configuration. | `string` | `null` | no |
| <a name="input_delete_default"></a> [delete\_default](#input\_delete\_default) | Deletes default created storage class. | `bool` | `false` | no |
| <a name="input_ebs_csi_version"></a> [ebs\_csi\_version](#input\_ebs\_csi\_version) | "EBS CSI" EKS addon version. | `string` | n/a | yes |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Name of the EKS cluster to deploy into. | `string` | n/a | yes |
| <a name="input_kms_encryption_keys"></a> [kms\_encryption\_keys](#input\_kms\_encryption\_keys) | Custom KMS encryption key to use for EBS volumes. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to AWS resources. | `map(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
