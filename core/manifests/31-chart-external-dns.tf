locals {
  enable_external_dns = var.enable_external_dns && length(var.allow_external_dns_zone_ids) != 0
}

module "external_dns" {
  source = "git@github.com:powise/terraform-modules//k8s/helm-release?ref=helm-release-0.3.1"

  count = local.enable_external_dns ? 1 : 0

  name = "external-dns"

  namespace        = "kube-system"
  create_namespace = false

  repository    = "https://charts.bitnami.com/bitnami"
  chart         = "external-dns"
  chart_version = "6.1.8"

  values = [
    templatefile(
      "${path.module}/templates/external-dns.yaml",
      {
        aws_region   = data.aws_region.current.name,
        eks_cluster  = var.eks_cluster,
        iam_role_arn = module.external_dns_role[0].arn,
        zone_ids     = var.allow_external_dns_zone_ids,
      }
    ),
  ]
}

module "external_dns_role" {
  source = "git@github.com:powise/terraform-modules//eks/oidc-role?ref=oidc-role-0.0.1"

  count = local.enable_external_dns ? 1 : 0

  eks_cluster = var.eks_cluster

  iam_role_name       = "eks-external-dns-${var.eks_cluster}-${data.aws_region.current.name}"
  iam_policy_document = data.aws_iam_policy_document.external_dns.json

  namespace       = "kube-system"
  service_account = "external-dns"
}

data "aws_iam_policy_document" "external_dns" {
  statement {
    sid = "ListAllZonesAndRecords"

    effect = "Allow"

    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
    ]

    resources = ["*"]
  }

  statement {
    sid = "UpdateRecordsInZones"

    effect = "Allow"

    actions = ["route53:ChangeResourceRecordSets"]

    resources = formatlist("arn:aws:route53:::hostedzone/%s", var.allow_external_dns_zone_ids)
  }
}
