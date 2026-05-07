variable "eks_cluster" {
  type = string

  description = "Name of the EKS cluster to deploy into."
}

variable "aws_region" {
  type = string

  description = "Name of the AWS region where the EKS cluster is deployed."
}

variable "aws_account_id" {
  type = string

  description = "ID of the AWS account where the EKS cluster is deployed."
}

variable "karpenter_namespace" {
  type = string

  default     = "kube-system"
  description = "The namespace to install the components in."
}

variable "karpenter_chart_version" {
  type = string

  default     = "1.0.1"
  description = "Karpenter chart version - must be at least 1.0.1."
}

variable "install_crds" {
  type = bool

  default     = true
  description = "CRDs appropriate for the current version will be managed using the separate Helm chart."
}

variable "timeout" {
  type = number

  default     = 300
  description = "Time in seconds to wait for release installation."
}

variable "iam_policy_statements" {
  type = any

  default     = []
  description = "A list of IAM policy statements - used for adding specific IAM permissions as needed."
}

variable "ami_id_ssm_parameter_arns" {
  type = list(string)

  default     = []
  description = "List of SSM Parameter ARNs that Karpenter controller is allowed read access (for retrieving AMI IDs)."
}

variable "worker_role_arn" {
  type = string

  description = "IAM role ARN to use to set PassRole permissions on controller role."
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to AWS resources."

  validation {
    condition = alltrue([
      contains(keys(var.tags), "team"),
      contains(keys(var.tags), "service"),
      contains(keys(var.tags), "impact"),
    ])
    error_message = "Required tags are missing! Please provide tags 'team', 'service' and 'impact'."
  }
}

variable "enable_spot_termination" {
  type = bool

  default     = true
  description = "Enable spot instance termination handling via SQS and EventBridge."
}

variable "queue_name" {
  type = string

  default     = null
  description = "Name of the SQS queue for spot interruption handling. If not provided, defaults to 'Karpenter-{cluster_name}'."
}

variable "queue_managed_sse_enabled" {
  type = bool

  default     = true
  description = "Enable SQS managed server-side encryption."
}

variable "queue_kms_master_key_id" {
  type = string

  default     = null
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK."
}

variable "queue_kms_data_key_reuse_period_seconds" {
  type = number

  default     = null
  description = "The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again."
}

variable "rule_name_prefix" {
  type = string

  default     = "Karpenter"
  description = "Prefix for EventBridge rule names."
}
