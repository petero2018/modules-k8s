locals {
  # Permissions
  cluster_resource_allow_list = var.cluster_resource_allow_list != null ? {
    clusterResourceWhitelist = var.cluster_resource_allow_list
  } : {}
  namespace_resource_allow_list = var.namespace_resource_allow_list != null ? {
    namespaceResourceWhitelist = var.namespace_resource_allow_list
  } : {}
  namespace_resource_deny_list = var.namespace_resource_deny_list != null ? {
    namespaceResourceBlacklist = var.namespace_resource_deny_list
  } : {}
  # Roles
  roles = var.roles != null ? {
    roles = [
      for name, config in var.roles : {
        name        = name
        description = config.description
        policies = [
          for policy in config.policies : "p, proj:${var.name}:${name}, ${coalesce(policy.resource, "applications")}, ${policy.action}, ${coalesce(policy.object, format("%s/*", var.name))}, allow"
        ]
      }
    ]
  } : {}
}

resource "kubernetes_manifest" "application" {
  manifest = {
    "apiVersion" = "argoproj.io/v1alpha1"
    "kind"       = "AppProject"
    "metadata" = {
      "name"       = var.name
      "namespace"  = var.namespace
      "finalizers" = var.finalizers
    }
    "spec" = merge({
      "description" = var.description
      "sourceRepos" = var.source_repos
      "destinations" = [
        for dest in var.destinations : {
          namespace = dest["namespace"], server = coalesce(dest["server"], "https://kubernetes.default.svc")
        }
      ]
      }, local.cluster_resource_allow_list, local.namespace_resource_allow_list,
    local.namespace_resource_deny_list, local.roles)
  }
}
