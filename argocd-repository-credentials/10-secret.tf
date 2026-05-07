locals {
  user_pass = var.username != null && var.password != null ? {
    username = var.username
    password = var.password
  } : {}
  ssh_private_key = var.ssh_private_key != null ? {
    sshPrivateKey = var.ssh_private_key
  } : {}
}

resource "kubectl_manifest" "repository_credentials" {
  yaml_body = yamlencode({
    apiVersion = "v1"
    kind       = "Secret"
    metadata = {
      name      = var.name
      namespace = var.namespace
      labels = merge({
        "argocd.argoproj.io/secret-type" : "repo-creds"
      }, var.labels)
      annotations = var.annotations
    }
    stringData = merge({
      url  = var.url
      type = var.type
    }, local.user_pass, local.ssh_private_key)
  })
  sensitive_fields = ["stringData"]
}
