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
        backend        = var.backend,
        tune_bufsize   = var.haproxy_config.tune_bufsize,
        block_indexing = var.block_indexing,
        strip_baggage  = var.strip_baggage,
      }
    )
  }
}
