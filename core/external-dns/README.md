# External DNS

Install [External DNS](https://github.com/kubernetes-sigs/external-dns) helm chart.

Synchronizes exposed Kubernetes Services and Ingresses with DNS providers.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | <3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_external_dns"></a> [external\_dns](#module\_external\_dns) | ../../helm-release | n/a |
| <a name="module_external_dns_role"></a> [external\_dns\_role](#module\_external\_dns\_role) | git@github.com:powise/terraform-modules//eks/irsa | eks-irsa-2.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.external_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_external_dns_zone_ids"></a> [allow\_external\_dns\_zone\_ids](#input\_allow\_external\_dns\_zone\_ids) | List of Route53 hosted zone IDs we allow ExternalDNS to access. | `list(string)` | `[]` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Region name where the cluster is running. This will be used for the name of the IAM role to be used by the controller. | `string` | n/a | yes |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | The version of external dns chart to install. | `string` | n/a | yes |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Name of the EKS cluster to deploy into. | `string` | n/a | yes |
| <a name="input_interval"></a> [interval](#input\_interval) | Poll interval to update the records. | `string` | `"1m"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to install the components in. | `string` | `"kube-system"` | no |
| <a name="input_node_selector"></a> [node\_selector](#input\_node\_selector) | Node labels for pod assignment. | `map(any)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to AWS resources. | `map(string)` | n/a | yes |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Time in seconds to wait for release installation. | `number` | `600` | no |
| <a name="input_txt_owner_id"></a> [txt\_owner\_id](#input\_txt\_owner\_id) | DNS record "owner ID" stored in accompanying TXT record (will be set to cluster name if empty) | `string` | `""` | no |
| <a name="input_watch_events"></a> [watch\_events](#input\_watch\_events) | Update records on events instead of just when polling. | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
