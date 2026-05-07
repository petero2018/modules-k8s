resource "kubernetes_config_map" "caddy" {
  metadata {
    name      = "${var.name}-config"
    namespace = var.namespace

    labels = local.labels
  }

  data = {
    "config.json" = templatefile(
      "${path.module}/templates/config.json",
      {
        dynamodb_table_name        = var.dynamodb_table_name,
        aws_region                 = data.aws_region.current.name,
        confirmation_endpoint_url  = var.confirmation_endpoint_url,
        proxied_host               = var.proxied_host,
        proxied_port               = var.proxied_port,
        alias_domain               = var.alias_domain,
        certificates_email         = var.certificates_email,
        allowed_cidrs              = jsonencode(var.allowed_cidrs),
        disable_http_challenge     = tostring(var.disable_http_challenge),
        disable_tls_alpn_challenge = tostring(var.disable_tls_alpn_challenge),
        log_level                  = var.log_level,
      }
    )
  }
}
