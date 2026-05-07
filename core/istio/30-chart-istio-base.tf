module "istio_base" {
  source = "git@github.com:powise/terraform-modules//k8s/helm-release?ref=helm-release-0.4.1"

  name = "istio-base"

  namespace        = module.namespace.namespace
  create_namespace = false

  chart         = "${data.external.istio.result["path"]}/manifests/charts/base"
  chart_version = var.istio_version

  set_values = {
    # Pilot
    "pilot.nodeSelector.kubernetes\\.io/arch" = var.deploy_arch
    "pilot.tolerations[0].key"                = "architecture"
    "pilot.tolerations[0].value"              = var.deploy_arch
    "pilot.tolerations[0].operator"           = "Equal"
    "pilot.tolerations[0].effect"             = "NoExecute"
  }
}
