resource "kubernetes_role_binding" "group_core" {
  for_each = toset(var.rbac_groups)

  metadata {
    name      = "group-core-${each.key}"
    namespace = kubernetes_namespace.core.metadata[0].name

    labels = local.labels
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = var.rbac_groups_readonly ? "view" : "cluster-admin"
  }

  subject {
    kind      = "Group"
    name      = each.key
    api_group = "rbac.authorization.k8s.io"
    namespace = kubernetes_namespace.core.metadata[0].name
  }
}

resource "kubernetes_role" "group_aux" {
  for_each = toset(var.rbac_groups)

  metadata {
    name      = "group-aux-${each.key}"
    namespace = kubernetes_namespace.core.metadata[0].name
  }

  rule {
    api_groups = ["config.istio.io", "networking.istio.io"]
    #checkov:skip=CKV_K8S_49:Developers need these permissions
    resources = ["*"]
    verbs     = ["get", "list", "watch"]
  }

  rule {
    api_groups = [""]
    resources  = ["pods/log"]
    verbs      = ["get", "list", "create"]
  }
}

resource "kubernetes_role_binding" "group_aux" {
  for_each = toset(var.rbac_groups)

  metadata {
    name      = kubernetes_role.group_aux[each.key].metadata[0].name
    namespace = kubernetes_namespace.core.metadata[0].name

    labels = local.labels
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.group_aux[each.key].metadata[0].name
  }

  subject {
    kind      = "Group"
    name      = each.key
    api_group = "rbac.authorization.k8s.io"
    namespace = kubernetes_namespace.core.metadata[0].name
  }
}
