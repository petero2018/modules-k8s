locals {
  ingress_class_name = coalesce(var.ingress_class_name, var.name)
}

module "release" {
  source = "../../../helm-release"

  name          = var.name
  description   = "ingress-nginx Helm Chart for ingress resources"
  chart         = "ingress-nginx"
  repository    = "https://kubernetes.github.io/ingress-nginx"
  chart_version = var.chart_version
  namespace     = var.namespace

  manage_via_argocd = var.manage_via_argocd
  argocd_app_config = var.argocd_app_config

  additional_helm_config = var.helm_config

  values = [
    templatefile("${path.module}/templates/values.yaml", {
      ingress_class_name          = local.ingress_class_name,
      ingress_service_type        = var.ingress_service_type,
      ingress_service_annotations = yamlencode(var.ingress_service_annotations),
      ingress_publish_service     = var.ingress_publish_service,
      ingress_min_replicas        = var.ingress_min_replicas
      ingress_max_replicas        = var.ingress_max_replicas
    })
  ]
}
