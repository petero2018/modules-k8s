resource "kubernetes_manifest" "target_group_binding_https" {
  manifest = {
    "apiVersion" = "elbv2.k8s.aws/v1beta1"
    "kind" = "TargetGroupBinding"
    "metadata" = {
      "name" = var.name
      "namespace" = var.namespace
    }
    "spec" = {
      "serviceRef" = {
        "name" = "${local.ingress_class_name}-ingress-nginx-controller"
        "port" = 443
      }
      "targetGroupARN" = var.target_group_arn
      "targetType" = var.target_group_type
    }
  }
}

resource "kubernetes_manifest" "target_group_binding_http" {
  count = var.http_target_group_arn != null ? 1 : 0


  manifest = {
    "apiVersion" = "elbv2.k8s.aws/v1beta1"
    "kind" = "TargetGroupBinding"
    "metadata" = {
      "name" = "${var.name}-http"
      "namespace" = var.namespace
    }
    "spec" = {
      "serviceRef" = {
        "name" = "${local.ingress_class_name}-ingress-nginx-controller"
        "port" = 80
      }
      "targetGroupARN" = var.target_group_arn
      "targetType" = var.target_group_type
    }
  }
}
