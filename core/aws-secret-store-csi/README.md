# AWS Secrets Store CSI Driver

The AWS provider for the Secrets Store CSI Driver allows you to make secrets stored in Secrets Manager and parameters stored in Parameter Store appear as files mounted in Kubernetes pods.

## Important Note

This module requires the Secrets Store CSI Driver to be installed first. Please ensure you install the `secrets-store-csi-driver` module before this one.

```hcl
module "secrets_store_csi_driver" {
  source = "../../k8s/core/secrets-store-csi-driver"

  chart_version = "1.3.4"  # Use the latest version compatible with your Kubernetes version
}

module "aws_secrets_store_csi" {
  source = "../../k8s/core/aws-secret-store-csi"

  chart_version = "0.3.4"  # Use the latest version compatible with your Kubernetes version

  # The AWS provider depends on the CSI driver being installed first
  depends_on = [module.secrets_store_csi_driver]
}
```

## Documentation
- https://github.com/aws/eks-charts/tree/master/stable/csi-secrets-store-provider-aws
- https://www.eksworkshop.com/beginner/194_secrets_manager/configure-csi-driver/
- https://secrets-store-csi-driver.sigs.k8s.io
- https://docs.aws.amazon.com/secretsmanager/latest/userguide/integrating_csi_driver.html
- https://github.com/aws/secrets-store-csi-driver-provider-aws
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
| <a name="module_release"></a> [release](#module\_release) | ../../helm-release | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argocd_app_config"></a> [argocd\_app\_config](#input\_argocd\_app\_config) | ArgoCD Application config. See k8s/argocd/resources/application | `any` | `{}` | no |
| <a name="input_chart_name"></a> [chart\_name](#input\_chart\_name) | The name of the Helm chart for the AWS Secrets Store CSI Driver. | `string` | `"csi-secrets-store-provider-aws"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | The version of Secret Store CSI to install. | `string` | n/a | yes |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if it does not yet exist. | `bool` | `false` | no |
| <a name="input_helm_config"></a> [helm\_config](#input\_helm\_config) | Helm provider config for Secret Store CSI | `any` | `{}` | no |
| <a name="input_manage_via_argocd"></a> [manage\_via\_argocd](#input\_manage\_via\_argocd) | Determines if the release should be managed via ArgoCD. | `bool` | `false` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to install the components in. | `string` | `"kube-system"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | The Helm chart repository URL for the AWS Secrets Store CSI Driver. | `string` | `"https://aws.github.io/eks-charts"` | no |
| <a name="input_secret_rotation"></a> [secret\_rotation](#input\_secret\_rotation) | When the secret/key is updated in external secrets store after the initial pod deployment, the updated secret will be periodically updated. | `bool` | `true` | no |
| <a name="input_secret_rotation_interval"></a> [secret\_rotation\_interval](#input\_secret\_rotation\_interval) | Rotation poll interval | `string` | `"2m"` | no |
| <a name="input_sync_secret"></a> [sync\_secret](#input\_sync\_secret) | It creates a Kubernetes Secret to mirror the mounted content. | `bool` | `true` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Time in seconds to wait for release installation. | `number` | `1200` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
