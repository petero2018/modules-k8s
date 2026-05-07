# Secrets Store CSI Driver

The Secrets Store CSI Driver allows Kubernetes to mount multiple secrets, keys, and certs stored in enterprise-grade external secrets stores into their pods as a volume. Once the volume is attached, the data in it is mounted into the container's file system.

This module installs the core Secrets Store CSI Driver, which is required before installing any provider-specific plugins like the AWS Secrets Store CSI Driver Provider.

## Documentation
- https://secrets-store-csi-driver.sigs.k8s.io/
- https://github.com/kubernetes-sigs/secrets-store-csi-driver
- https://kubernetes-sigs.github.io/secrets-store-csi-driver/getting-started/installation/

## Usage

```hcl
module "secrets_store_csi_driver" {
  source = "../../k8s/core/secrets-store-csi-driver"

  chart_version = "1.3.4"  # Use the latest version compatible with your Kubernetes version
}

# After installing the CSI driver, you can install the AWS provider
module "aws_secrets_store_csi" {
  source = "../../k8s/core/aws-secret-store-csi"

  chart_version = "0.3.4"  # Use the latest version compatible with your Kubernetes version

  # The AWS provider depends on the CSI driver being installed first
  depends_on = [module.secrets_store_csi_driver]
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_release"></a> [release](#module\_release) | ../../helm-release | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart_name"></a> [chart\_name](#input\_chart\_name) | The name of the Helm chart for the Secrets Store CSI Driver. | `string` | `"secrets-store-csi-driver"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | The version of Secrets Store CSI Driver to install. | `string` | n/a | yes |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if it does not yet exist. | `bool` | `false` | no |
| <a name="input_helm_config"></a> [helm\_config](#input\_helm\_config) | Helm provider config for Secrets Store CSI Driver | `any` | `{}` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to install the components in. | `string` | `"kube-system"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | The Helm chart repository URL for the Secrets Store CSI Driver. | `string` | `"https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"` | no |
| <a name="input_secret_rotation"></a> [secret\_rotation](#input\_secret\_rotation) | When the secret/key is updated in external secrets store after the initial pod deployment, the updated secret will be periodically updated. | `bool` | `true` | no |
| <a name="input_secret_rotation_interval"></a> [secret\_rotation\_interval](#input\_secret\_rotation\_interval) | Rotation poll interval | `string` | `"2m"` | no |
| <a name="input_sync_secret"></a> [sync\_secret](#input\_sync\_secret) | It creates a Kubernetes Secret to mirror the mounted content. | `bool` | `true` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Time in seconds to wait for release installation. | `number` | `1200` | no |

## Outputs

No outputs.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.6 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_release"></a> [release](#module\_release) | ../../helm-release | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart_name"></a> [chart\_name](#input\_chart\_name) | The name of the Helm chart for the Secrets Store CSI Driver. | `string` | `"secrets-store-csi-driver"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | The version of Secrets Store CSI Driver to install. | `string` | n/a | yes |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if it does not yet exist. | `bool` | `false` | no |
| <a name="input_helm_config"></a> [helm\_config](#input\_helm\_config) | Helm provider config for Secrets Store CSI Driver | `any` | `{}` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to install the components in. | `string` | `"kube-system"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | The Helm chart repository URL for the Secrets Store CSI Driver. | `string` | `"https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"` | no |
| <a name="input_secret_rotation"></a> [secret\_rotation](#input\_secret\_rotation) | When the secret/key is updated in external secrets store after the initial pod deployment, the updated secret will be periodically updated. | `bool` | `true` | no |
| <a name="input_secret_rotation_interval"></a> [secret\_rotation\_interval](#input\_secret\_rotation\_interval) | Rotation poll interval | `string` | `"2m"` | no |
| <a name="input_sync_secret"></a> [sync\_secret](#input\_sync\_secret) | It creates a Kubernetes Secret to mirror the mounted content. | `bool` | `true` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Time in seconds to wait for release installation. | `number` | `1200` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
