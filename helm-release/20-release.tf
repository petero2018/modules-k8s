################################################################################
# Helm Release
################################################################################

resource "helm_release" "release" {
  count = var.manage_via_argocd ? 0 : 1

  name                       = local.helm_config.name
  repository                 = local.helm_config.repository
  chart                      = local.helm_config.chart
  version                    = local.helm_config.version
  timeout                    = local.helm_config.timeout
  values                     = local.helm_config.values
  create_namespace           = local.helm_config.create_namespace
  namespace                  = local.helm_config.namespace
  lint                       = local.helm_config.lint
  description                = local.helm_config.description
  repository_key_file        = local.helm_config.repository_key_file
  repository_cert_file       = local.helm_config.repository_cert_file
  repository_username        = local.helm_config.repository_username
  repository_password        = local.helm_config.repository_password
  verify                     = local.helm_config.verify
  keyring                    = local.helm_config.keyring
  disable_webhooks           = local.helm_config.disable_webhooks
  reuse_values               = local.helm_config.reuse_values
  reset_values               = local.helm_config.reset_values
  force_update               = local.helm_config.force_update
  recreate_pods              = local.helm_config.recreate_pods
  cleanup_on_fail            = local.helm_config.cleanup_on_fail
  max_history                = local.helm_config.max_history
  atomic                     = local.helm_config.atomic
  skip_crds                  = local.helm_config.skip_crds
  render_subchart_notes      = local.helm_config.render_subchart_notes
  disable_openapi_validation = local.helm_config.disable_openapi_validation
  wait                       = local.helm_config.wait
  wait_for_jobs              = local.helm_config.wait_for_jobs
  dependency_update          = local.helm_config.dependency_update
  replace                    = local.helm_config.replace

  dynamic "set" {
    for_each = try(var.deploy_arch != null, false) ? [true] : []

    content {
      name  = "nodeSelector.kubernetes\\.io/arch"
      value = var.deploy_arch
      type  = "string"
    }
  }

  dynamic "set" {
    for_each = try(var.deploy_arch != null, false) ? [true] : []

    content {
      name  = "tolerations[0].key"
      value = "architecture"
    }
  }

  dynamic "set" {
    for_each = try(var.deploy_arch != null, false) ? [true] : []

    content {
      name  = "tolerations[0].value"
      value = var.deploy_arch
    }
  }

  dynamic "set" {
    for_each = try(var.deploy_arch != null, false) ? [true] : []

    content {
      name  = "tolerations[0].operator"
      value = "Equal"
    }
  }

  dynamic "set" {
    for_each = try(var.deploy_arch != null, false) ? [true] : []

    content {
      name  = "tolerations[0].effect"
      value = "NoExecute"
    }
  }

  dynamic "set" {
    for_each = var.set_values

    content {
      name  = set.key
      value = set.value
    }
  }

  dynamic "set" {
    for_each = var.set_string_values

    content {
      name  = set.key
      value = set.value
      type  = "string"
    }
  }

  dynamic "set_sensitive" {
    for_each = local.helm_config.set_sensitive

    content {
      name  = set_sensitive.key
      value = set_sensitive.value
    }
  }

  dynamic "postrender" {
    for_each = var.kustomization_file != null ? ["_"] : []

    content {
      binary_path = "${path.module}/scripts/kustomize.sh"
      args        = [abspath(var.kustomization_file)]
    }
  }
}

moved { # Terraform 1.1+ rename hint to avoid recreating resources
  from = helm_release.main
  to   = helm_release.release[0]
}

################################################################################
# ArgoCD App
################################################################################

module "argo_app" {
  count = var.manage_via_argocd ? 1 : 0

  source = "../argocd-application"

  name      = local.helm_config.name
  namespace = lookup(var.argocd_app_config, "namespace", "argocd")
  project   = lookup(var.argocd_app_config, "project", "default")

  repo_url             = local.helm_config.repository
  target_revision      = local.helm_config.version
  chart                = local.helm_config.chart
  set_values           = local.helm_config.set_values
  set_string_values    = local.helm_config.set_string_values
  set_sensitive_values = local.helm_config.set_sensitive
  values               = local.helm_config.values
  repo_path            = local.helm_config.repo_path
  value_files          = local.helm_config.value_files

  destination_namespace = local.helm_config.namespace

  sync_automated             = lookup(var.argocd_app_config, "sync_automated", true)
  sync_automated_prune       = lookup(var.argocd_app_config, "sync_automated_prune", true)
  sync_automated_self_heal   = lookup(var.argocd_app_config, "sync_automated_self_heal", true)
  sync_automated_allow_empty = lookup(var.argocd_app_config, "sync_automated_allow_empty", false)

  sync_retry                = lookup(var.argocd_app_config, "sync_retry", 5)
  sync_backoff_duration     = lookup(var.argocd_app_config, "sync_backoff_duration", "5s")
  sync_backoff_factor       = lookup(var.argocd_app_config, "sync_backoff_factor", 2)
  sync_backoff_max_duration = lookup(var.argocd_app_config, "sync_backoff_max_duration", "3m")

  sync_validate                 = lookup(var.argocd_app_config, "sync_validate", true)
  sync_create_namespace         = local.helm_config.create_namespace
  sync_prune_propagation_policy = lookup(var.argocd_app_config, "sync_prune_propagation_policy", "foreground")
  sync_prune_last               = lookup(var.argocd_app_config, "sync_prune_last", true)
}
