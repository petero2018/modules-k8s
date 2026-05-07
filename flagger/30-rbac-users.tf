resource "kubernetes_role_binding" "user_view" {
  for_each = toset(var.rbac_users)

  metadata {
    name      = "user-view-${each.key}"
    namespace = kubernetes_namespace.flagger.metadata[0].name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole" # HINT: ClusterRole bound with namespaced RoleBinding will have limited, namespaced permissions!
    name      = "view"
  }

  subject {
    kind      = "User"
    name      = each.key
    api_group = "rbac.authorization.k8s.io"
    namespace = kubernetes_namespace.flagger.metadata[0].name
  }
}

resource "kubernetes_cluster_role" "user_custom_resources" {
  for_each = toset(var.rbac_users)

  metadata {
    name = "user-custom-resources-${each.key}"
  }

  rule {
    api_groups = ["flagger.app"]
    resources  = ["canaries", "metrictemplates", "alertproviders"]
    verbs      = var.rbac_users_readonly ? ["get", "list", "watch"] : ["get", "list", "watch", "create", "update", "patch", "delete"]
  }
}

resource "kubernetes_cluster_role_binding" "user_custom_resources" {
  for_each = toset(var.rbac_users)

  metadata {
    name = kubernetes_cluster_role.user_custom_resources[each.key].metadata[0].name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.user_custom_resources[each.key].metadata[0].name
  }

  subject {
    kind      = "User"
    name      = each.key
    api_group = "rbac.authorization.k8s.io"
  }
}
