resource "kubernetes_secret" "haproxy" {
  metadata {
    name      = var.name
    namespace = var.namespace

    labels = local.labels
  }

  data = {
    "haproxy.pem" = join(
      "\n",
      [
        tls_private_key.haproxy.private_key_pem,
        tls_self_signed_cert.haproxy.cert_pem,
      ]
    )
  }

  type = "generic"
}

resource "tls_private_key" "haproxy" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "tls_self_signed_cert" "haproxy" {
  key_algorithm   = "ECDSA"
  private_key_pem = tls_private_key.haproxy.private_key_pem

  subject {
    common_name  = var.name
    organization = "powise"
  }

  validity_period_hours = 87600

  allowed_uses = [
    "server_auth",
    "client_auth",
    "key_agreement",
    "key_encipherment",
    "data_encipherment",
    "digital_signature",
  ]
}
