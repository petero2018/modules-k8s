# External Secrets 1Password Secret

Creates a `External Secret` CRD to sync a 1Password secret into a Kubernetes Secret.

## Documentation

- https://external-secrets.io/v0.5.9/provider-1password-automation/

## Example

```hcl
module "example_secret" {
  source = "git@github.com:powise/terraform-modules//k8s/core/external-secrets-1password-secret?ref=core-external-secrets-1password-secret-0.0.1"

  name        = "aws-secret" # Name of the External Secrets CRD
  secret_name = "aws-secret" # Name of the Kubernetes Secret (by default the same as name)
  namespace   = "some-namespace" # Namespace to place the secret

  refresh_interval = "1h" # Refresh interval to use for the secret (default 1 hour)

  secrets   = {
    # data key to store the 1password secret in
    MY_ENV_VAR1 = {
      # Name of the 1password secret
      key      = "my-env-config"
      # Name of the 1password property
      property = "MY_ENV_VAR1"
    }
    PASSWORD = {
      key      = "my-env-config"
      # Password is a special keyword to get passwords
      property = "password"
    }
  }

  secret_store_name = "1password" # secret store name
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
| <a name="module_wait"></a> [wait](#module\_wait) | git@github.com:powise/terraform-modules//k8s/wait-resource | wait-resource-0.0.1 |

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.external_secret](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_creation_policy"></a> [creation\_policy](#input\_creation\_policy) | Values: Owner creates the secret, Merge does not create the secret. | `string` | `"Owner"` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | EKS cluster name, needed to wait resource creation. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | External Secret Name | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace where to create the secret | `string` | n/a | yes |
| <a name="input_refresh_interval"></a> [refresh\_interval](#input\_refresh\_interval) | amount of time before the values reading again from the SecretStore. | `string` | `"1h"` | no |
| <a name="input_secret_name"></a> [secret\_name](#input\_secret\_name) | Kubernetes Secret Name. Keep it unset to default to name. | `string` | `null` | no |
| <a name="input_secret_store_name"></a> [secret\_store\_name](#input\_secret\_store\_name) | Secret Store Name. | `string` | `"1password"` | no |
| <a name="input_secret_store_type"></a> [secret\_store\_type](#input\_secret\_store\_type) | Store type to create: SecretStore (to be namespaced), ClusterSecretStore (to be used cluster scoped) | `string` | `"ClusterSecretStore"` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | Secrets to retrieve from 1password. | <pre>map(object({<br>    key      = string<br>    property = string<br>  }))</pre> | n/a | yes |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Time in seconds to wait for secret creation. | `number` | `60` | no |
| <a name="input_wait"></a> [wait](#input\_wait) | Will wait until secret is created and sync successfully. | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
