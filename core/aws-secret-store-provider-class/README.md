# AWS Secret Store Provider Class

Creates a provider class to fetch kubernetes secrets from `Secret Manager` or `Parameter Store`

## Dependencies
This module creates a `SecretProviderClass` for defining secrets.
In order to this to work the `aws-secret-store-csi` must be installed on the cluster.

## Documentation
- [`Secret Store`](https://docs.aws.amazon.com/secretsmanager/latest/userguide/integrating_csi_driver.html)
- [`Parameter Store`](https://docs.aws.amazon.com/systems-manager/latest/userguide/integrating_csi_driver.html)

## Example

```hcl
module "example_provider_class" {
  source = "git@github.com:powise/terraform-modules//k8s/core/aws-secret-store-provider-class?ref=core-aws-secret-store-provider-class-0.0.1"

  name    = "example-secret"
  objects = [
    {
      name  = "example-secret"
      type  = "secretsmanager"
      alias = "secret-alias"
    },
    {
      name  = "/test/parameter"
      type  = "ssmparameter"
      alias = "parameter-alias"
    }
  ]

  generate_iam_policy = true
}

module "example_irsa" {
  source = "git@github.com:powise/terraform-modules//eks/irsa?ref=eks-irsa-0.0.1"

  eks_cluster = local.eks_cluster

  namespace = "example"

  service_account        = "example-sa"
  create_service_account = true

  iam_policies_documents = {
    "secret-access" : {
      description = "Provides Access to Secrets defined in the provider class"
      policy      = module.example_provider_class.iam_policy
    }
  }

  tags = var.tags
}

resource "kubernetes_deployment_v1" "example_deployment" {
  metadata {
    name      = "example-deployment"
    namespace = "example"
    labels    = {
      app = "example-secret"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "example-secret"
      }
    }
    template {
      metadata {
        name   = "example-secret"
        labels = {
          app = "example-secret"
        }
        annotations = {
          config-hash = sha256(module.provider_class.iam_policy)
        }
      }
      spec {
        service_account_name = "example-sa"
        volume {
          name = "secrets-store"
          csi {
            driver            = "secrets-store.csi.k8s.io"
            read_only         = true
            volume_attributes = {
              secretProviderClass = "example-secret"
            }
          }
        }
        container {
          name  = "example-secret"
          image = "nginx"
          port {
            container_port = 80
          }
          volume_mount {
            mount_path = "/mnt/secrets-store"
            name       = "secrets-store"
            read_only  = true
          }
        }
      }
    }
  }
}

```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.13.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.13.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.provider_class](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [aws_iam_policy_document.secret_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_secretsmanager_secret.secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_ssm_parameter.parameters](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_generate_iam_policy"></a> [generate\_iam\_policy](#input\_generate\_iam\_policy) | If true generates a IAM policy to be used by the IRSA. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the Provider Class | `string` | n/a | yes |
| <a name="input_objects"></a> [objects](#input\_objects) | Declaration of the secrets to be mounted. | <pre>list(object({<br>    name          = string<br>    paths         = optional(map(string))<br>    type          = string<br>    alias         = optional(string)<br>    version       = optional(string)<br>    version_label = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_path_translation"></a> [path\_translation](#input\_path\_translation) | A single substitution character to use if the file name (either objectName or objectAlias) contains the path separator character, such as slash (/) on Linux. | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS Region of the parameter. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_policy"></a> [iam\_policy](#output\_iam\_policy) | IAM Policy to get secrets defined in this secret store. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
