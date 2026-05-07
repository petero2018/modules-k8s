locals {
  # Volume Values
  volume_values = merge({
    "persistentVolume.size"      = var.pv_size
    "persistentVolume.sizeLimit" = var.pv_size_max
    }, var.pv_class != null ? tomap({
      "persistentVolume.storageClass" = var.pv_class
  }) : {})
  # Ingress Values
  ingress_values = var.enable_ingress ? tomap({
    "ingress.enabled"   = true
    "ingress.host"      = var.ingress_domain
    "ingress.className" = var.ingress_class
  }) : {}
  # API Groups
  api_groups_values = {
    for idx, api_group in var.crd_api_groups : "clusterRole.apiGroups[${idx}]" => api_group
  }
}

module "release" {
  source = "../argocd-application"

  name = "sloop"

  repo_url        = "https://github.com/salesforce/sloop"
  repo_path       = "helm/sloop"
  target_revision = var.git_version

  set_values = merge(local.volume_values, local.ingress_values, local.api_groups_values)
  values = [
    templatefile("${path.module}/templates/values.yaml", {
      watch_crd = var.watch_crd
    })
  ]

  namespace  = lookup(var.argocd_app_config, "namespace", "argocd")
  project    = lookup(var.argocd_app_config, "project", "default")
  finalizers = lookup(var.argocd_app_config, "finalizers", ["resources-finalizer.argocd.argoproj.io"])

  timeout     = var.timeout
  eks_cluster = lookup(var.argocd_app_config, "eks_cluster")

  destination_cluster   = lookup(var.argocd_app_config, "destination_cluster", "https://kubernetes.default.svc")
  destination_namespace = var.namespace

  sync_automated             = lookup(var.argocd_app_config, "sync_automated", true)
  sync_automated_prune       = lookup(var.argocd_app_config, "sync_automated_prune", true)
  sync_automated_self_heal   = lookup(var.argocd_app_config, "sync_automated_self_heal", true)
  sync_automated_allow_empty = lookup(var.argocd_app_config, "sync_automated_allow_empty", false)

  sync_retry                = lookup(var.argocd_app_config, "sync_retry", 5)
  sync_backoff_duration     = lookup(var.argocd_app_config, "sync_backoff_duration", "5s")
  sync_backoff_factor       = lookup(var.argocd_app_config, "sync_backoff_factor", 2)
  sync_backoff_max_duration = lookup(var.argocd_app_config, "sync_backoff_max_duration", "3m")

  sync_validate                 = lookup(var.argocd_app_config, "sync_validate", true)
  sync_create_namespace         = var.create_namespace
  sync_prune_propagation_policy = lookup(var.argocd_app_config, "sync_prune_propagation_policy", "foreground")
  sync_prune_last               = lookup(var.argocd_app_config, "sync_prune_last", true)

  ignore_differences = lookup(var.argocd_app_config, "ignore_differences", [])
}
