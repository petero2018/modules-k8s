module "istio_egress" {
  count = var.install_egress_gateway ? 1 : 0

  source = "git@github.com:powise/terraform-modules//k8s/helm-release?ref=helm-release-0.4.1"

  name = "istio-egress"

  namespace        = module.namespace.namespace
  create_namespace = false

  chart         = "${data.external.istio.result["path"]}/manifests/charts/gateways/istio-egress"
  chart_version = var.istio_version

  set_values = {
    "global.hub" = local.hub

    "gateways.istio-egressgateway.autoscaleEnabled" = "true"
    "gateways.istio-egressgateway.autoscaleMin"     = "2"
    "gateways.istio-egressgateway.autoscaleMax"     = "16"

    # Allow setting of nodeSelector. For example, don't put the control plane pods on Spot instances
    "gateways.istio-egressgateway.nodeSelector.${var.capacity_type_selector.key}" = var.capacity_type_selector.value

    # Egress Gateway
    "gateways.istio-egressgateway.nodeSelector.kubernetes\\.io/arch" = var.deploy_arch
    "gateways.istio-egressgateway.tolerations[0].key"                = "architecture"
    "gateways.istio-egressgateway.tolerations[0].value"              = var.deploy_arch
    "gateways.istio-egressgateway.tolerations[0].operator"           = "Equal"
    "gateways.istio-egressgateway.tolerations[0].effect"             = "NoExecute"
  }

  depends_on = [module.istio_base]
}

moved {
  from = module.istio_egress
  to   = module.istio_egress[0]
}
