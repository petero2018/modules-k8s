resource "kubernetes_cluster_role" "app" {
  count = length(var.cluster_rbac_rules) == 0 ? 0 : 1

  metadata {
    name = var.name

    labels = local.labels
  }

  dynamic "rule" {
    for_each = var.cluster_rbac_rules

    content {
      api_groups = rule.value.api_groups
      resources  = rule.value.resources
      verbs      = rule.value.verbs
    }
  }
}

resource "kubernetes_cluster_role_binding" "app" {
  count = length(var.cluster_rbac_rules) == 0 ? 0 : 1

  metadata {
    name = var.name

    labels = local.labels
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.app[0].metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.app.metadata[0].name
    namespace = local.namespace
  }
}
