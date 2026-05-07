# External Secrets Store

Creates a `Secret Store` CRD to access AWS Resources.
Optionally (`create_irsa=true`) it can:
- Create the IRSA (IAM Role) needed to access the secrets.
- Create the Service Account linked to the IRSA (IAM Role).

## Documentation

- https://external-secrets.io/v0.5.7/api-secretstore/
- https://external-secrets.io/v0.5.7/provider-aws-secrets-manager/
- https://external-secrets.io/v0.5.7/provider-aws-parameter-store/
- https://aws.amazon.com/es/blogs/containers/leverage-aws-secrets-stores-from-eks-fargate-with-external-secrets-operator/

## Example

```hcl
module "example_provider_class" {
  source = "git@github.com:powise/terraform-modules//k8s/core/external-secrets-aws-store?ref=core-external-secrets-aws-store-0.0.1"

  name      = "aws-secret-provider"
  namespace = "some-namespace"

  # Setup IRSA to access AWS Resources
  create_irsa = true
  eks_cluster = "cluster-name"
  tags        = var.tags

  # AWS Provider Configuration
  aws_service = "SecretsManager"
  # Secrets to grant access
  secrets     = [
    "secret-1",
    "secret-2"
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=3.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >=1.13.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=3.0 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >=1.13.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_irsa"></a> [irsa](#module\_irsa) | ../../../eks/irsa | n/a |
| <a name="module_wait"></a> [wait](#module\_wait) | git@github.com:powise/terraform-modules//k8s/wait-resource | wait-resource-0.0.1 |

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.secret_store](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [aws_iam_policy_document.secret_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_secretsmanager_secret.secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_ssm_parameter.parameters](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region to grant access. | `string` | `null` | no |
| <a name="input_aws_service"></a> [aws\_service](#input\_aws\_service) | Service to allow access. | `string` | `"SecretsManager"` | no |
| <a name="input_create_irsa"></a> [create\_irsa](#input\_create\_irsa) | Creates IRSA for the Secret Store. | `bool` | `true` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Name of the EKS cluster to deploy into. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the Secret Store | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace where to create the Secret Store. | `string` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | SSM Parameters or AWS Secrets to grant access. | `list(string)` | `[]` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | service account name to use for the Secret Store | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to AWS resources. | `map(string)` | n/a | yes |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Time in seconds to wait for secret creation. | `number` | `60` | no |
| <a name="input_wait"></a> [wait](#input\_wait) | Will wait until secret is created and sync successfully. | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
