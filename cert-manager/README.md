# cert-manager

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.6 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_irsa"></a> [irsa](#module\_irsa) | git@github.com:powise/terraform-modules//eks/irsa | eks-irsa-2.1.0 |
| <a name="module_release"></a> [release](#module\_release) | git@github.com:powise/terraform-modules//k8s/helm-release | helm-release-0.4.2 |

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.cluster_issuer_letsencrypt_production](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.cluster_issuer_letsencrypt_staging](https://registry.terraform.io/providers/alekc/kubectl/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acme_email"></a> [acme\_email](#input\_acme\_email) | Email to use for the ACME challenge. | `string` | `"ops+cert-manager@powise.com"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Name of the current AWS region. | `string` | n/a | yes |
| <a name="input_deploy_arch"></a> [deploy\_arch](#input\_deploy\_arch) | Node architecture to deploy to. Must be either "amd64" or "arm64" | `string` | `"arm64"` | no |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Name of the EKS cluster to deploy into. | `string` | n/a | yes |
| <a name="input_enable_cainjector"></a> [enable\_cainjector](#input\_enable\_cainjector) | Whether to enable the CA Injector component. | `bool` | `true` | no |
| <a name="input_route53_zones"></a> [route53\_zones](#input\_route53\_zones) | List of Route53 zones to act upon. | <pre>list(object({<br>    id     = string<br>    domain = string<br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to AWS resources. | `map(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
