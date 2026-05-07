resource "helm_release" "flagger" {
  name = "flagger"

  namespace        = kubernetes_namespace.flagger.metadata[0].name
  create_namespace = false

  repository = "https://flagger.app"
  chart      = "flagger"
  version    = var.chart_version

  timeout = var.chart_timeout

  set {
    name  = "nodeSelector.kubernetes\\.io/arch"
    value = var.deploy_arch
    type  = "string"
  }

  set {
    name  = "tolerations[0].key"
    value = "architecture"
  }

  set {
    name  = "tolerations[0].value"
    value = var.deploy_arch
  }

  set {
    name  = "tolerations[0].operator"
    value = "Equal"
  }

  set {
    name  = "tolerations[0].effect"
    value = "NoExecute"
  }

  set {
    name  = "meshProvider"
    value = "istio"
  }

  set {
    name  = "metricsServer"
    value = "http://prometheus.istio-system:9090"
  }

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "crd.create"
    value = "false"
  }

  set {
    name  = "selectorLabels"
    value = "deploy"
  }

  set {
    name  = "includeLabelPrefix"
    value = "*"
  }

  set {
    name  = "resources.requests.memory"
    value = var.flagger_request_memory
  }

  set {
    name  = "resources.requests.cpu"
    value = var.flagger_request_cpu
  }

  set {
    name  = "kubeconfigQPS"
    value = "500"
  }

  set {
    name  = "kubeconfigBurst"
    value = "1000"
  }
}
