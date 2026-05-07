resource "kubernetes_manifest" "security_group_policy" {

  manifest = {
    apiVersion = "vpcresources.k8s.aws/v1beta1"
    kind       = "SecurityGroupPolicy"

    metadata = {
      name      = var.name
      namespace = var.namespace
    }

    spec = {
      "${var.selector}" = {
        matchLabels      = var.match_labels
        matchExpressions = var.match_expressions
      }

      securityGroups = {
        groupIds = var.security_group_ids
      }
    }
  }
}
