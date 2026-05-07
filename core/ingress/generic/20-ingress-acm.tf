data "aws_route53_zone" "ingress" {
  count = var.acm_certificate_arn == null ? 1 : 0

  name = var.dns_zone
}

module "certificate" {
  count = var.acm_certificate_arn == null ? 1 : 0

  source  = "jpamies/certificate/aws"
  version = "~>1.0"

  dns_zone_id = data.aws_route53_zone.ingress[0].zone_id

  domain_name               = var.ingress_type == "powise-nlb" ? "${var.eks_cluster}.${var.hostname}" : var.hostname
  subject_alternative_names = var.ingress_type == "powise-nlb" ? ["*.${var.eks_cluster}.${var.hostname}"] : ["*.${var.hostname}"]

  tags = {
    "Role" = "ingress"
  }
}
