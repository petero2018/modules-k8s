locals {
  tls_secret_namespace = var.tls_secret_namespace == null ? var.namespace : var.tls_secret_namespace
}

resource "kubernetes_secret" "ingressgateway" {
  metadata {
    name      = "ingressgateway-${var.name}"
    namespace = local.tls_secret_namespace
  }

  data = {
    cert = tls_self_signed_cert.ingressgateway.cert_pem
    key  = tls_private_key.ingressgateway.private_key_pem
  }

  type = "tls"
}

resource "tls_private_key" "ingressgateway" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "tls_self_signed_cert" "ingressgateway" {
  key_algorithm   = "ECDSA"
  private_key_pem = tls_private_key.ingressgateway.private_key_pem

  subject {
    common_name  = var.hostname
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
