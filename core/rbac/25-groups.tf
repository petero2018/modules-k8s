resource "kubernetes_cluster_role_binding" "binding" {
  for_each = {
    for auth in flatten([
      for group in var.groups : [
        for auth in group.global : {
          name : group.name
          auth : auth
        }
      ]
    ]) : "${auth.name}-${auth.auth}" => auth
  }

  metadata {
    name = each.key
    labels = merge({
      "app.kubernetes.io/name" : "rbac-group",
      "app.kubernetes.io/instance" : each.key
    }, local.labels)
    annotations = local.annotations
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = each.value.auth
  }

  subject {
    kind      = "Group"
    name      = each.value.name
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "kubernetes_role_binding" "binding" {
  for_each = {
    for auth in flatten([
      for group in var.groups : [
        for namespace in group.namespace != null ? tolist(group.namespace) : [] : [
          for auth in group.namespace[namespace] : {
            name : group.name
            namespace : namespace
            auth : auth
          }
        ]
      ]
    ]) : "${auth.name}-${auth.namespace}-${auth.auth}" => auth
  }

  metadata {
    name      = each.key
    namespace = each.value.namespace
    labels = merge({
      "app.kubernetes.io/name" : "rbac-group",
      "app.kubernetes.io/instance" : each.key
    }, local.labels)
    annotations = local.annotations
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = each.value.auth
  }

  subject {
    kind      = "Group"
    name      = each.value.name
    api_group = "rbac.authorization.k8s.io"
  }
}
