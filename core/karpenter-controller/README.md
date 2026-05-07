# Karpenter Controller

Karpenter is an open-source node provisioning project built for Kubernetes. Karpenter automatically launches just the right compute resources to handle your cluster's applications. It is designed to let you take full advantage of the cloud with fast and simple compute provisioning for Kubernetes clusters.

This module deploys the Karpenter controller with support for spot instance interruption handling via SQS and EventBridge.

## Features

- **Karpenter Controller**: Deploys the latest Karpenter controller with IRSA
- **Spot Interruption Handling**: Automatic SQS queue and EventBridge rules for graceful spot instance termination
- **IAM Permissions**: Comprehensive IAM policies for EC2, SQS, and EKS operations
- **Configurable**: Flexible configuration options for different use cases

## Spot Interruption Handling

When `enable_spot_termination` is set to `true` (default), the module creates:

1. **SQS Queue**: Receives spot interruption notifications
2. **EventBridge Rules**: Captures AWS events for:
   - EC2 Spot Instance Interruption Warning
   - EC2 Instance Rebalance Recommendation
   - EC2 Instance State-change Notification
   - AWS Health Events
3. **IAM Permissions**: Allows Karpenter to read from the SQS queue

This enables Karpenter to gracefully handle spot instance interruptions by:
- Receiving advance notice of spot interruptions
- Cordoning and draining nodes before termination
- Automatically provisioning replacement capacity

For more details checkout [Karpenter](https://karpenter.sh/docs/getting-started/) docs
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_karpenter_crd_release"></a> [karpenter\_crd\_release](#module\_karpenter\_crd\_release) | ../../helm-release | n/a |
| <a name="module_karpenter_release"></a> [karpenter\_release](#module\_karpenter\_release) | ../../helm-release | n/a |
| <a name="module_karpenter_role"></a> [karpenter\_role](#module\_karpenter\_role) | git@github.com:powise/terraform-modules//eks/irsa | eks-irsa-2.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.interruption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.interruption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_sqs_queue.interruption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue_policy.interruption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |
| [aws_iam_policy_document.interruption_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.karpenter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id_ssm_parameter_arns"></a> [ami\_id\_ssm\_parameter\_arns](#input\_ami\_id\_ssm\_parameter\_arns) | List of SSM Parameter ARNs that Karpenter controller is allowed read access (for retrieving AMI IDs). | `list(string)` | `[]` | no |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | ID of the AWS account where the EKS cluster is deployed. | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Name of the AWS region where the EKS cluster is deployed. | `string` | n/a | yes |
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | Name of the EKS cluster to deploy into. | `string` | n/a | yes |
| <a name="input_enable_spot_termination"></a> [enable\_spot\_termination](#input\_enable\_spot\_termination) | Enable spot instance termination handling via SQS and EventBridge. | `bool` | `true` | no |
| <a name="input_iam_policy_statements"></a> [iam\_policy\_statements](#input\_iam\_policy\_statements) | A list of IAM policy statements - used for adding specific IAM permissions as needed. | `any` | `[]` | no |
| <a name="input_install_crds"></a> [install\_crds](#input\_install\_crds) | CRDs appropriate for the current version will be managed using the separate Helm chart. | `bool` | `true` | no |
| <a name="input_karpenter_chart_version"></a> [karpenter\_chart\_version](#input\_karpenter\_chart\_version) | Karpenter chart version - must be at least 1.0.1. | `string` | `"1.0.1"` | no |
| <a name="input_karpenter_namespace"></a> [karpenter\_namespace](#input\_karpenter\_namespace) | The namespace to install the components in. | `string` | `"kube-system"` | no |
| <a name="input_queue_kms_data_key_reuse_period_seconds"></a> [queue\_kms\_data\_key\_reuse\_period\_seconds](#input\_queue\_kms\_data\_key\_reuse\_period\_seconds) | The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. | `number` | `null` | no |
| <a name="input_queue_kms_master_key_id"></a> [queue\_kms\_master\_key\_id](#input\_queue\_kms\_master\_key\_id) | The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK. | `string` | `null` | no |
| <a name="input_queue_managed_sse_enabled"></a> [queue\_managed\_sse\_enabled](#input\_queue\_managed\_sse\_enabled) | Enable SQS managed server-side encryption. | `bool` | `true` | no |
| <a name="input_queue_name"></a> [queue\_name](#input\_queue\_name) | Name of the SQS queue for spot interruption handling. If not provided, defaults to 'Karpenter-{cluster\_name}'. | `string` | `null` | no |
| <a name="input_rule_name_prefix"></a> [rule\_name\_prefix](#input\_rule\_name\_prefix) | Prefix for EventBridge rule names. | `string` | `"Karpenter"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to AWS resources. | `map(string)` | n/a | yes |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Time in seconds to wait for release installation. | `number` | `300` | no |
| <a name="input_worker_role_arn"></a> [worker\_role\_arn](#input\_worker\_role\_arn) | IAM role ARN to use to set PassRole permissions on controller role. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_interruption_queue_arn"></a> [interruption\_queue\_arn](#output\_interruption\_queue\_arn) | ARN of the SQS queue for spot interruption handling |
| <a name="output_interruption_queue_name"></a> [interruption\_queue\_name](#output\_interruption\_queue\_name) | Name of the SQS queue for spot interruption handling |
| <a name="output_karpenter_role_arn"></a> [karpenter\_role\_arn](#output\_karpenter\_role\_arn) | ARN of the Karpenter controller IAM role |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
