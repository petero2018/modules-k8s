module "irsa" {
  source = "git@github.com:powise/terraform-modules//eks/irsa?ref=eks-irsa-2.1.0"

  eks_clusters = [var.eks_cluster]

  namespace        = local.namespace
  service_accounts = [local.service_account_name]
  iam_role_name    = "cert-manager-${var.aws_region}-${var.eks_cluster}"

  iam_policy_documents = {
    "dns-edit" = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect   = "Allow"
          Action   = "route53:GetChange"
          Resource = "arn:aws:route53:::change/*"
        },
        {
          Effect = "Allow"
          Action = [
            "route53:ChangeResourceRecordSets",
            "route53:ListResourceRecordSets"
          ]
          Resource = formatlist("arn:aws:route53:::hostedzone/%s", [for zone in var.route53_zones : zone.id])
        },
        {
          Effect   = "Allow"
          Action   = "route53:ListHostedZonesByName"
          Resource = "*"
        }
      ]
    })
  }

  tags = var.tags
}
