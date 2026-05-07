resource "kubernetes_config_map" "haproxy_config" {
  metadata {
    name      = "${var.name}-config"
    namespace = var.namespace

    labels = local.labels
  }

  data = {
    "haproxy.cfg" = templatefile(
      "${path.module}/templates/haproxy.cfg",
      {
        backend = var.backend,
      }
    )
  }
}
