data "aws_iam_policy_document" "velero_backups" {
  #checkov:skip=CKV_AWS_111:This is a resource-based policy. "*" in this case applies only to the resource to which this policy is attached.
  #checkov:skip=CKV_AWS_356:This is a resource-based policy. "*" in this case applies only to the resource to which this policy is attached.

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:DescribeVolumes",
      "ec2:DescribeSnapshots",
      "ec2:CreateTags",
      "ec2:CreateVolume",
      "ec2:CreateSnapshot",
      "ec2:DeleteSnapshot"
    ]
  }

  statement {
    sid    = ""
    effect = "Allow"
    resources = [
      "arn:aws:s3:::${var.template_values["backup_bucket"]}/*"
    ]

    actions = [
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutObject",
      "s3:AbortMultipartUpload",
      "s3:ListMultipartUploadParts"
    ]
  }

  statement {
    sid    = ""
    effect = "Allow"
    resources = [
      "arn:aws:s3:::${var.template_values["backup_bucket"]}"
    ]

    actions = [
      "s3:ListBucket"
    ]
  }

}
