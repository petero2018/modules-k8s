locals {
  # Helm Source
  source_helm = var.chart != null ? {
    chart = var.chart
  } : {}
  # Source Revision
  source_revision = var.target_revision != null ? {
    targetRevision = var.target_revision
  } : {}
  source_git_path = var.repo_path != null ? {
    path = var.repo_path
  } : {}

  helm = {
    helm = {
      releaseName    = coalesce(var.release_name, var.name)
      parameters     = local.helm_parameters
      fileParameters = var.file_values
      valueFiles     = var.value_files
      values         = yamlencode(merge([for value in var.values : yamldecode(value)]...))
    }
  }

  # Helm Parameters
  helm_parameters = concat(
    # Set Values
    [for key, value in var.set_values : { name = key, value = value }],
    # Set String Values
    [for key, value in var.set_string_values : { name = key, value = value, forceString = true }],
    # Set Sensitive Values
    [for key, value in var.set_sensitive_values : { name = key, value = value }]
  )

  # Sync Automated
  sync_automated = var.sync_automated ? {
    automated = {
      prune      = var.sync_automated_prune
      selfHeal   = var.sync_automated_self_heal
      allowEmpty = var.sync_automated_allow_empty
    }
  } : {}
  sync_automated_retry = var.sync_automated ? {
    retry = {
      limit = var.sync_retry
      backoff = {
        duration    = var.sync_backoff_duration
        factor      = var.sync_backoff_factor
        maxDuration = var.sync_backoff_max_duration
      }
    }
  } : {}
}
resource "kubernetes_manifest" "application" {
  manifest = {
    "apiVersion" = "argoproj.io/v1alpha1"
    "kind"       = "Application"
    "metadata" = {
      "labels" = merge({
        "name" = var.name
      }, var.labels)
      "name"      = var.name
      "namespace" = var.namespace
    }
    "spec" = {
      "destination" = {
        "namespace" = var.destination_namespace
        "server"    = "https://kubernetes.default.svc"
      }
      "project" = var.project
      "source" = merge(
        {
          "repoURL" = var.repo_url
        },
        local.helm,
        local.source_helm,
        local.source_revision,
        local.source_git_path
      )
      "syncPolicy" = merge({
        syncOptions = [
          "Validate=${var.sync_validate}",
          "CreateNamespace=${var.sync_create_namespace}",
          "PrunePropagationPolicy=${var.sync_prune_propagation_policy}",
          "PruneLast=${var.sync_prune_last}"
        ]
        },
        local.sync_automated,
        local.sync_automated_retry
      )
    }
  }
  field_manager {
    force_conflicts = true
  }
  wait {
    fields = {
      "status.sync.status" = "Synced"
    }
  }
}
