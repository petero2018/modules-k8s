module "release" {
  source = "../helm-release"

  name = "fluentbit"

  namespace        = var.namespace
  create_namespace = var.create_namespace

  repository    = "https://fluent.github.io/helm-charts"
  chart         = "fluent-bit"
  chart_version = var.chart_version

  manage_via_argocd = var.manage_via_argocd
  argocd_app_config = var.argocd_app_config

  timeout = var.timeout

  set_values = {
    # Service Account
    "serviceAccount.create" = true
    "serviceAccount.name"   = "fluentbit"
    "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn" : module.irsa.irsa_iam_role_arn
    # RBAC
    "rbac.nodeAccess" = true
    # Readiness Probe
    "readinessProbe.httpGet.path" = "/"
    # Log Level
    "logLevel" = "info"
  }

  values = [
    local.template,
    file("${path.module}/templates/volumes.yaml"),
    file("${path.module}/templates/annotations.yaml"),
    yamlencode({
      "tolerations" = concat(var.tolerations, [{ operator = "Exists" }]) # Tolerate everything to be on all nodes
    })
  ]

  depends_on = [
    module.irsa,
  ]
}
