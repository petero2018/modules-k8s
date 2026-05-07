module "helm_snyk" {
  source = "../helm-release"

  name = local.name

  namespace = module.namespace.namespace

  create_namespace = false

  manage_via_argocd = var.manage_via_argocd
  argocd_app_config = var.argocd_app_config

  repository    = "https://snyk.github.io/kubernetes-monitor"
  chart         = local.name
  chart_version = var.chart_version

  values = [
    yamlencode({
      clusterName         = var.eks_cluster
      workloadPoliciesMap = kubernetes_config_map.snyk_monitor_custom_policies.metadata[0].name
      policyOrgs          = [local.integration_id]
      # Only schedule on AMD64 nodes
      nodeSelector = {
        "kubernetes.io/arch" = "amd64"
      }
    })
  ]

  timeout = 600
}
