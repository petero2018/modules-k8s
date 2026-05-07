data "aws_iam_policy_document" "kms_key" {
  # https://docs.aws.amazon.com/eks/latest/userguide/csi-iam-role.html
  count = length(var.kms_encryption_keys) > 0 ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant"
    ]
    resources = var.kms_encryption_keys
    condition {
      test = "Bool"
      values = [
        "true"
      ]
      variable = "kms:GrantIsForAWSResource"
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = var.kms_encryption_keys
  }
}

locals {
  kms_policies = length(var.kms_encryption_keys) > 0 ? tomap({
    "kms-encryption" : {
      description = "Provides access to EBS CSI driver to encrypt EBS volumes using a custom KMS keys."
      policy      = data.aws_iam_policy_document.kms_key[0].json
    }
  }) : tomap({})
}
