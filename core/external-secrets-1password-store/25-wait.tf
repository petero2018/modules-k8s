module "wait" {
  source = "git@github.com:powise/terraform-modules//k8s/wait-resource?ref=wait-resource-0.0.1"

  count = var.wait ? 1 : 0

  name           = var.name
  namespace      = var.namespace
  resource       = "${var.store_type}.external-secrets.io"
  json_path      = ".status.conditions[?(@.type==\"Ready\")].reason"
  expected_value = "Valid"
  error_message  = "It takes too long to create store..."
  timeout        = var.timeout
  wait_trigger   = kubectl_manifest.cluster_store.yaml_body

  eks_cluster = var.eks_cluster
}
