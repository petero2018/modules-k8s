resource "kubernetes_config_map" "squid_config" {
  metadata {
    name      = "${var.name}-config"
    namespace = var.namespace

    labels = local.labels
  }

  data = {
    "squid.conf" = templatefile(
      "${path.module}/templates/squid.conf",
      {
        denied_cidrs = var.denied_cidrs,
      }
    )
  }
}
