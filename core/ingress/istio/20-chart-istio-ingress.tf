module "istio_ingress" {
  source = "git@github.com:powise/terraform-modules//k8s/helm-release?ref=helm-release-0.4.1"

  name = var.name

  namespace        = var.namespace
  create_namespace = false

  chart         = "${local.istio_charts_path}/gateways/istio-ingress"
  chart_version = var.istio_version

  set_values = merge(
    {
      "global.hub" = local.hub

      "gateways.istio-ingressgateway.name" = var.name
      "gateways.istio-ingressgateway.type" = var.ingress_service_type

      "gateways.istio-ingressgateway.autoscaleEnabled" = "true"
      "gateways.istio-ingressgateway.autoscaleMin"     = var.min_pods
      "gateways.istio-ingressgateway.autoscaleMax"     = var.max_pods
    },
    local.istio_ingress_labels,
    local.load_balancer_service_annotations,
    local.keep_source_ip_values,
    local.proxy_config_annotations,
    local.role_arn_annotation,
    local.global_deploy_arch,
    local.capacity_type_selector,
    local.ports,
    var.anti_affinity.per_az.enable ? local.az_anti_affinity : {},
    var.anti_affinity.per_host.enable ? local.host_anti_affinity : {},
  )

  values = var.enable_csi ? [yamlencode({
    "gateways" = {
      "istio-ingressgateway" = {
        "secretVolumes" = [],
        "podAnnotations" = {
          "kustomizationHash" = filesha256("${path.module}/files/kustomization.yaml")
        }
      }
    }
  })] : []

  kustomization_file = var.enable_csi ? "${path.module}/files/kustomization.yaml" : null
}
