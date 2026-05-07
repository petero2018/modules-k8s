module "external_dns" {
  source = "../../helm-release"

  name        = "external-dns"
  description = "ExternalDNS addon that configures public DNS servers with information about exposed Kubernetes services to make them discoverable."

  repository    = "oci://registry-1.docker.io/bitnamicharts"
  chart         = "external-dns"
  chart_version = var.chart_version

  namespace = var.namespace

  values = [
    templatefile("${path.module}/templates/external-dns.yaml", {
      aws_region    = var.aws_region,
      txt_owner_id  = var.txt_owner_id != "" ? var.txt_owner_id : var.eks_cluster,
      iam_role_arn  = module.external_dns_role.irsa_iam_role_arn,
      zone_ids      = var.allow_external_dns_zone_ids,
      interval      = var.interval,
      watch_events  = tostring(var.watch_events),
      node_selector = yamlencode(var.node_selector)
    })
  ]

  timeout = var.timeout
}

module "external_dns_role" {
  source = "git@github.com:powise/terraform-modules//eks/irsa?ref=eks-irsa-2.1.0"

  eks_clusters = [var.eks_cluster]

  iam_role_name = "eks-external-dns-${var.eks_cluster}-${var.aws_region}"
  iam_policy_documents = {
    "eks-external-dns-${var.eks_cluster}-${var.aws_region}-policy" = data.aws_iam_policy_document.external_dns.json
  }

  namespace        = var.namespace
  service_accounts = ["external-dns"]

  tags = local.tags
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

moved {
  from = module.external_dns[0].module.external_dns[0].helm_release.release[0]
  to   = module.external_dns[0].module.external_dns.helm_release.release[0]
}

moved {
  from = module.external_dns[0].module.external_dns_role[0].aws_iam_role.oidc
  to   = module.external_dns[0].module.external_dns_role.module.irsa.aws_iam_role.role
}

moved {
  from = module.external_dns[0].module.external_dns_role[0].aws_iam_role_policy.oidc
  to   = module.external_dns[0].module.external_dns_role.module.irsa.aws_iam_role_policy.creation["eks-external-dns-dev-blue-eu-west-1-policy"]
}
