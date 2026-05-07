module "wait" {
  source = "../../wait-resource"

  count = var.wait ? 1 : 0

  name           = var.name
  namespace      = var.namespace
  resource       = "externalsecret.external-secrets.io"
  json_path      = ".status.conditions[?(@.type==\"Ready\")].reason"
  expected_value = "SecretSynced"
  error_message  = "It takes too long to sync..."
  timeout        = var.timeout
  wait_trigger   = kubectl_manifest.external_secret.yaml_body

  eks_cluster = var.eks_cluster
}
