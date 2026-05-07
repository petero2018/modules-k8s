resource "kubernetes_role_binding" "cicd_core" {
  metadata {
    name      = "cicd-core"
    namespace = kubernetes_namespace.core.metadata[0].name

    labels = local.labels
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "User"
    name      = "cicd"
    api_group = "rbac.authorization.k8s.io"
    namespace = kubernetes_namespace.core.metadata[0].name
  }
}
