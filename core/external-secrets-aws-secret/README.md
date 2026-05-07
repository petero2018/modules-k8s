# External Secrets Store

Creates an `External Secret` CRD to sync a SecretManager or ParameterStore into a kubernetes secret.
Optionally (`create_secret_store=true`) it can:
- Create the External Secret AWS Store with IRSA configured.

## Documentation

- https://external-secrets.io/v0.5.7/api-externalsecret/
- https://external-secrets.io/v0.5.7/provider-aws-secrets-manager/
- https://external-secrets.io/v0.5.7/provider-aws-parameter-store/

## Example

```hcl
module "example_secret" {
  source = "git@github.com:powise/terraform-modules//k8s/core/external-secrets-aws-secret?ref=core-external-secrets-aws-secret-0.0.1"

  name        = "aws-secret" # Name of the External Secrets CRD
  secret_name = "aws-secret" # Name of the Kubernetes Secret (by default the same as name)
  namespace   = "some-namespace" # Namespace to place the secret

  refresh_interval = "1h" # Refresh interval to use for the secret (default 1 hour)

  secrets = {
    # data key to store the AWS secret in
    first-secret = {
      # AWS Secret store or SSM Parameter name
      key      = "my-json-secret"
      # (optional) if the value is a json, the json property to fetch
      property = "first.secret"
      # (optional) the version of the AWS Secret
      version  = "first-version"
    },
    # data key to store the AWS secret in
    second-secret = {
      key      = "my-json-secret"
      property = "second.secret"
    }
  }

  # Setup Secrets AWS Store to access the secret (with IRSA)
  create_secret_store = true # By default enabled
  eks_cluster         = "cluster-name"

  tags = var.tags
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >=1.13.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >=1.13.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_secret_store"></a> [secret\_store](#module\_secret\_store) | ../external-secrets-aws-store | n/a |
| <a name="module_wait"></a> [wait](#module\_wait) | ../../wait-resource | n/a |

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.external_secret](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region to grant access. | `string` | `null` | no |
| <a name="input_aws_service"></a> [aws\_service](#input\_aws\_service) | Service to allow access. | `string` | `"SecretsManager"` | no |
| <a name="input_create_irsa"></a> [create\_irsa](#input\_create\_irsa) | Creates IRSA for the Secret Store. | `bool` | `true` | no |
| <a name="input_create_secret_store"></a> [create\_secret\_store](#input\_create\_secret\_store) | Flag to create the secret store needed for this secret. | `bool` | `true` | no |
| <a name="input_creation_policy"></a> [creation\_policy](#input\_creation\_policy) | Values: Owner creates the secret, Merge does not create the secret. | `string` | `"Owner"` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Name of the EKS cluster to deploy into. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | External Secret name. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace where to create the secret. | `string` | n/a | yes |
| <a name="input_refresh_interval"></a> [refresh\_interval](#input\_refresh\_interval) | amount of time before the values reading again from the SecretStore. | `string` | `"1h"` | no |
| <a name="input_secret_name"></a> [secret\_name](#input\_secret\_name) | Kubernetes Secret Name. Keep it unset to default to name. | `string` | `null` | no |
| <a name="input_secret_store_name"></a> [secret\_store\_name](#input\_secret\_store\_name) | AWS Secret Store Name. | `string` | `null` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | Secrets to retrieve from SecretManager or ParameterStore. | <pre>map(object({<br>    key      = string<br>    property = optional(string)<br>    version  = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | service account name to use for the Secret Store | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to AWS resources. | `map(string)` | n/a | yes |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Time in seconds to wait for secret creation. | `number` | `60` | no |
| <a name="input_wait"></a> [wait](#input\_wait) | Will wait until secret is created and sync successfully. | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
