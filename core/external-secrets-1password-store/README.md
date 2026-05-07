# External Secrets 1Password Store

Creates a `Secret Cluster Store` CRD to access 1Password secrets.
- This store is cluster wide

## Documentation

- https://external-secrets.io/v0.5.9/provider-1password-automation/

## Dependencies
1Password Store needs from 1Password Connect to be deployed in the kubernetes cluster to fetch the secrets from 1Password

## Example

```hcl
module "1password_provider" {
  source = "git@github.com:powise/terraform-modules//k8s/core/external-secrets-1password-store?ref=core-external-secrets-1password-store-0.0.1"

  # SSM Path for the access token
  access_token_ssm_path = "/integrations/1password/token/external-secrets-operator"
  # Vaults to give access to the provider (should be scoped also in the access token creation)
  vaults       = [
    "Vault1", "Vault2"
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
| <a name="module_wait"></a> [wait](#module\_wait) | git@github.com:powise/terraform-modules//k8s/wait-resource | wait-resource-0.0.1 |

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.cluster_store](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.token_secret](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [aws_ssm_parameter.access_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_token_ssm_path"></a> [access\_token\_ssm\_path](#input\_access\_token\_ssm\_path) | SSM parameter with 1password access token | `string` | n/a | yes |
| <a name="input_connect_url"></a> [connect\_url](#input\_connect\_url) | URL of the 1password connect service | `string` | `"http://onepassword-connect:8080"` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | EKS cluster name, needed to wait resource creation. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the Secret Store | `string` | `"1password"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to use if the store type is namespaced. | `string` | `null` | no |
| <a name="input_secret_namespace"></a> [secret\_namespace](#input\_secret\_namespace) | Where to store the 1Password secrets. | `string` | `"kube-system"` | no |
| <a name="input_store_type"></a> [store\_type](#input\_store\_type) | Store type to create: SecretStore (to be namespaced), ClusterSecretStore (to be used cluster scoped) | `string` | `"ClusterSecretStore"` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Time in seconds to wait for secret creation. | `number` | `60` | no |
| <a name="input_vaults"></a> [vaults](#input\_vaults) | 1Password vaults to grant access to external secrets operator store | `list(string)` | n/a | yes |
| <a name="input_wait"></a> [wait](#input\_wait) | Will wait until secret store is created and sync successfully. | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
