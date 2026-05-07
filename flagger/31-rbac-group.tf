resource "kubernetes_role_binding" "group_view" {
  for_each = toset(var.rbac_groups)

  metadata {
    name      = "group-view-${each.key}"
    namespace = kubernetes_namespace.flagger.metadata[0].name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole" # HINT: ClusterRole bound with namespaced RoleBinding will have limited, namespaced permissions!
    name      = "view"
  }

  subject {
    kind      = "Group"
    name      = each.key
    api_group = "rbac.authorization.k8s.io"
    namespace = kubernetes_namespace.flagger.metadata[0].name
  }
}

resource "kubernetes_cluster_role" "group_custom_resources" {
  for_each = toset(var.rbac_groups)

  metadata {
    name = "group-custom-resources-${each.key}"
  }

  rule {
    api_groups = ["flagger.app"]
    resources  = ["canaries", "metrictemplates", "alertproviders"]
    verbs      = var.rbac_groups_readonly ? ["get", "list", "watch"] : ["get", "list", "watch", "create", "update", "patch", "delete"]
  }
}

resource "kubernetes_cluster_role_binding" "group_custom_resources" {
  for_each = toset(var.rbac_groups)

  metadata {
    name = kubernetes_cluster_role.group_custom_resources[each.key].metadata[0].name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.group_custom_resources[each.key].metadata[0].name
  }

  subject {
    kind      = "Group"
    name      = each.key
    api_group = "rbac.authorization.k8s.io"
  }
}
