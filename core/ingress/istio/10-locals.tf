resource "random_string" "name" {
  length  = 32
  lower   = true
  upper   = false
  numeric = true
  special = false
}

locals {
  hub = var.hub != null ? var.hub : "567716553783.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/infra/istio"

  # Name of the provisioned load balancer (visible in AWS console etc)
  load_balancer_name = substr("${var.name}-${random_string.name.result}", 0, 32)

  # Label selectors for Gateway CRD
  istio_ingress_labels = { for k, v in var.ingress_labels : "gateways.istio-ingressgateway.labels.${k}" => v }

  # Annotations to apply for when the service type is a load balancer
  load_balancer_service_annotations = var.ingress_service_type == "LoadBalancer" ? (
    merge({
      "gateways.istio-ingressgateway.serviceAnnotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-scheme"                            = var.load_balancer_scheme
      "gateways.istio-ingressgateway.serviceAnnotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-name"                              = local.load_balancer_name
      "gateways.istio-ingressgateway.serviceAnnotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"                              = "nlb-ip"
      "gateways.istio-ingressgateway.serviceAnnotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-cross-zone-load-balancing-enabled" = "true"
      "gateways.istio-ingressgateway.serviceAnnotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-ports"                         = "https"
      "gateways.istio-ingressgateway.serviceAnnotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-backend-protocol"                  = "ssl"
      "gateways.istio-ingressgateway.serviceAnnotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-additional-resource-tags"          = "name=${local.load_balancer_name}\\,team=product-infrastructure\\,impact=critical\\,service=eks"
      "gateways.istio-ingressgateway.serviceAnnotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-healthcheck-port"                  = var.load_balancer_healthcheck_port
      },
      var.acm_certificate_arn != null ? { "gateways.istio-ingressgateway.serviceAnnotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-cert" = var.acm_certificate_arn } : {}
    )
  ) : ({})

  # Annotations to apply for when we want to keep the source IP of the original request
  keep_source_ip_values = var.keep_source_ip && var.ingress_service_type == "LoadBalancer" ? (
    {
      "gateways.istio-ingressgateway.serviceAnnotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-target-group-attributes" = "preserve_client_ip.enabled=true"
      "gateways.istio-ingressgateway.externalTrafficPolicy"                                                                         = "Local"
    }
  ) : ({})

  # Annotation to trust a number of reverse proxies to fetch source IP from the X-Forwarded-For HTTP header
  trusted_proxies_service_annotation = var.num_trusted_proxies > 0 ? (
    "\"gatewayTopology\": \\{\"numTrustedProxies\": ${var.num_trusted_proxies}\\}\\"
  ) : ""
  termination_drain_duration_annotation = "\"terminationDrainDuration\": ${var.termination_drain_duration}s"
  proxy_config_annotations = ({
    "gateways.istio-ingressgateway.podAnnotations.proxy\\.istio\\.io/config" = "\\{${join(", ", compact([local.trusted_proxies_service_annotation, local.termination_drain_duration_annotation]))}\\}"
  })

  # Annotation to associate the ingress gateway's service account with an IAM role (IRSA)
  role_arn_annotation = var.aws_iam_role_arn == null ? ({}) : ({
    "gateways.istio-ingressgateway.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn" = var.aws_iam_role_arn
  })

  # Path with downloaded istio chart manifests
  istio_charts_path = var.istio_charts_path == null ? "${data.external.istio[0].result["path"]}/manifests/charts" : var.istio_charts_path

  # Define the node architecture to run pods on
  global_deploy_arch = {
    "gateways.istio-ingressgateway.nodeSelector.kubernetes\\.io/arch" = var.deploy_arch
    "gateways.istio-ingressgateway.tolerations[0].key"                = "architecture"
    "gateways.istio-ingressgateway.tolerations[0].value"              = var.deploy_arch
    "gateways.istio-ingressgateway.tolerations[0].operator"           = "Equal"
    "gateways.istio-ingressgateway.tolerations[0].effect"             = "NoExecute"
  }

  # Allow setting of nodeSelector. For example, don't put the control plane pods on Spot instances
  capacity_type_selector = {
    "gateways.istio-ingressgateway.nodeSelector.${var.capacity_type_selector.key}" = var.capacity_type_selector.value
  }

  # EKS Auto Mode TargetGroupBinding CRD selection
  targetgroupbinding_crd = var.eks_auto_mode ? "eks.amazonaws.com/v1" : "elbv2.k8s.aws/v1beta1"

  # Ingress gateway ports
  ports = merge(
    { # These are the static default port configurations from the Helm chart default values
      "gateways.istio-ingressgateway.ports[0].port"       = 15021
      "gateways.istio-ingressgateway.ports[0].targetPort" = 15021
      "gateways.istio-ingressgateway.ports[0].name"       = "status-port"
      "gateways.istio-ingressgateway.ports[0].protocol"   = "TCP"

      "gateways.istio-ingressgateway.ports[1].port"       = 80
      "gateways.istio-ingressgateway.ports[1].targetPort" = 8080
      "gateways.istio-ingressgateway.ports[1].name"       = "http2"
      "gateways.istio-ingressgateway.ports[1].protocol"   = "TCP"

      "gateways.istio-ingressgateway.ports[2].port"       = 443
      "gateways.istio-ingressgateway.ports[2].targetPort" = 8443
      "gateways.istio-ingressgateway.ports[2].name"       = "https"
      "gateways.istio-ingressgateway.ports[2].protocol"   = "TCP"
    },
    [ # Adding extra listening ports as needed
      for index, config in var.extra_ports :
      {
        ("gateways.istio-ingressgateway.ports[${3 + index}].port")       = config.port
        ("gateways.istio-ingressgateway.ports[${3 + index}].targetPort") = config.targetPort
        ("gateways.istio-ingressgateway.ports[${3 + index}].name")       = config.name
        ("gateways.istio-ingressgateway.ports[${3 + index}].protocol")   = config.protocol
      }
    ]...
  )

  # Anti affinity settings
  host_anti_affinity_hardness = var.anti_affinity.per_host.hard ? "podAntiAffinityLabelSelector" : "podAntiAffinityTermLabelSelector"
  az_anti_affinity_hardness   = var.anti_affinity.per_az.hard ? "podAntiAffinityLabelSelector" : "podAntiAffinityTermLabelSelector"

  host_anti_affinity_index = var.anti_affinity.per_az.enable && var.anti_affinity.per_host.enable ? 1 : 0

  az_anti_affinity = {
    ("gateways.istio-ingressgateway.${local.az_anti_affinity_hardness}[0].key")         = "app.kubernetes.io/name"
    ("gateways.istio-ingressgateway.${local.az_anti_affinity_hardness}[0].operator")    = "In"
    ("gateways.istio-ingressgateway.${local.az_anti_affinity_hardness}[0].values")      = "istio-ingressgateway"
    ("gateways.istio-ingressgateway.${local.az_anti_affinity_hardness}[0].topologyKey") = "topology.kubernetes.io/zone"
  }

  host_anti_affinity = {
    ("gateways.istio-ingressgateway.${local.host_anti_affinity_hardness}[${local.host_anti_affinity_index}].key")         = "kubernetes.io/hostname"
    ("gateways.istio-ingressgateway.${local.host_anti_affinity_hardness}[${local.host_anti_affinity_index}].operator")    = "In"
    ("gateways.istio-ingressgateway.${local.host_anti_affinity_hardness}[${local.host_anti_affinity_index}].values")      = "istio-ingressgateway"
    ("gateways.istio-ingressgateway.${local.host_anti_affinity_hardness}[${local.host_anti_affinity_index}].topologyKey") = "topology.kubernetes.io/zone"
  }
}
