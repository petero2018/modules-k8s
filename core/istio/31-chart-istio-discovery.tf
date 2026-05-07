module "istio_discovery" {
  source = "git@github.com:powise/terraform-modules//k8s/helm-release?ref=helm-release-0.4.1"

  name = "istio-discovery"

  namespace        = module.namespace.namespace
  create_namespace = false

  chart         = "${data.external.istio.result["path"]}/manifests/charts/istio-control/istio-discovery"
  chart_version = var.istio_version

  set_values = {
    "global.hub" = local.hub

    "pilot.autoscaleEnabled"                    = "true"
    "pilot.autoscaleMin"                        = "2"
    "pilot.autoscaleMax"                        = "16"
    "pilot.env.ENABLE_LEGACY_FSGROUP_INJECTION" = tostring(var.enable_legacy_fsgroup_injection)

    # Allow setting of nodeSelector. For example, don't put the control plane pods on Spot instances
    "pilot.nodeSelector.${var.capacity_type_selector.key}" = var.capacity_type_selector.value
    # Blocks the start of the other containers until the proxy is ready
    "global.proxy.holdApplicationUntilProxyStarts" = tostring(var.hold_application)
    # Notes:
    # This updates default injection template, NOT already deprecated global value.
    # Each pod may override these defaults with annotations:
    #   proxy.istio.io/config: '{ "holdApplicationUntilProxyStarts": true|false }'

    "global.proxy.includeIPRanges"      = length(var.include_ip_ranges) == 0 ? "*" : join("\\,", var.include_ip_ranges)
    "global.proxy.excludeOutboundPorts" = join("\\,", var.exclude_outbound_ports)

    "global.proxy.resources.requests.cpu"    = var.sidecar_requests.cpu
    "global.proxy.resources.requests.memory" = var.sidecar_requests.memory
    # Pilot
    "pilot.nodeSelector.kubernetes\\.io/arch" = var.deploy_arch
    "pilot.tolerations[0].key"                = "architecture"
    "pilot.tolerations[0].value"              = var.deploy_arch
    "pilot.tolerations[0].operator"           = "Equal"
    "pilot.tolerations[0].effect"             = "NoExecute"

    # Pilot: spread across AZs
    "pilot.topologySpreadConstraints[0].maxSkew"                         = 1
    "pilot.topologySpreadConstraints[0].topologyKey"                     = "topology.kubernetes.io/zone"
    "pilot.topologySpreadConstraints[0].whenUnsatisfiable"               = "ScheduleAnyway"
    "pilot.topologySpreadConstraints[0].labelSelector.matchLabels.istio" = "pilot"

    # Pilot: avoid running on the same hosts
    "pilot.topologySpreadConstraints[1].maxSkew"                         = 1
    "pilot.topologySpreadConstraints[1].topologyKey"                     = "kubernetes.io/hostname"
    "pilot.topologySpreadConstraints[1].whenUnsatisfiable"               = "ScheduleAnyway"
    "pilot.topologySpreadConstraints[1].labelSelector.matchLabels.istio" = "pilot"

    # Ingress Gateway
    "gateways.istio-ingressgateway.nodeSelector.kubernetes\\.io/arch" = var.deploy_arch
    "gateways.istio-ingressgateway.tolerations[0].key"                = "architecture"
    "gateways.istio-ingressgateway.tolerations[0].value"              = var.deploy_arch
    "gateways.istio-ingressgateway.tolerations[0].operator"           = "Equal"
    "gateways.istio-ingressgateway.tolerations[0].effect"             = "NoExecute"
  }

  depends_on = [module.istio_base]
}
