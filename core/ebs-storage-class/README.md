# EBS Storage Class

This module creates an AWS EBS CSI driver Storage class to allow use EBS volumes.

## GP3 Example

```hcl
module "gp3_class" {
  source = "git@github.com:powise/terraform-modules//k8s/core/ebs-storage-class?ref=k8s-core-ebs-storage-class-0.0.1"

  name        = "gp3"
  default     = true
  file_system = "ext4"
  volume_type = "gp3"
  encrypted   = true

  # Optional: KMS key
  kms_key = "arn:aws:kms:us-east-1:231559676060:key/7e54fe72-29b1-4e74-b663-f9148b90cd0b"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.4 |
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
| [kubectl_manifest.storage_class](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_volume_expansion"></a> [allow\_volume\_expansion](#input\_allow\_volume\_expansion) | This feature when set to true, allows the users to resize the volume by editing the corresponding PVC object. | `bool` | `true` | no |
| <a name="input_annotations"></a> [annotations](#input\_annotations) | Annotations to be applied to K8S resources. | `map(string)` | `{}` | no |
| <a name="input_auto_iops"></a> [auto\_iops](#input\_auto\_iops) | When true the CSI driver increases IOPS for a volume when iopsPerGB * <volume size> is too low to fit into IOPS range supported by AWS. | `bool` | `false` | no |
| <a name="input_default"></a> [default](#input\_default) | Is the default storage class to use. | `bool` | `false` | no |
| <a name="input_encrypted"></a> [encrypted](#input\_encrypted) | Whether the volume should be encrypted or not. | `bool` | `true` | no |
| <a name="input_file_system"></a> [file\_system](#input\_file\_system) | File system type that will be formatted during volume creation: xfs, ext2, ext3, ext4. | `string` | `"ext4"` | no |
| <a name="input_iops"></a> [iops](#input\_iops) | I/O operations per second. Only effetive when gp3 volume type is specified. | `number` | `null` | no |
| <a name="input_iops_per_gb"></a> [iops\_per\_gb](#input\_iops\_per\_gb) | I/O operations per second per GiB. Required when io1 or io2 volume type is specified. | `number` | `null` | no |
| <a name="input_kms_key"></a> [kms\_key](#input\_kms\_key) | The full ARN of the key to use when encrypting the volume. | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to be applied to K8S resources. | `map(string)` | `{}` | no |
| <a name="input_mount_options"></a> [mount\_options](#input\_mount\_options) | Linux mount options to apply to PVCs created with this storage class. | `list(string)` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Storage Class Name. | `string` | n/a | yes |
| <a name="input_reclaim_policy"></a> [reclaim\_policy](#input\_reclaim\_policy) | It describes the Kubernetes action when the PV is released. | `string` | `"Delete"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the volume. | `map(string)` | `{}` | no |
| <a name="input_throughput"></a> [throughput](#input\_throughput) | Throughput in MiB/s. Only effective when gp3 volume type is specified. | `number` | `null` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | EBS volume type: io1, io2, gp2, gp3, sc1, st1, standard. | `string` | `"gp3"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
