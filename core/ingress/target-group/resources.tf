locals {
  target_group_name = regex("targetgroup/([^/]+)/", var.target_group_arn)[0]
}

resource "kubectl_manifest" "target_group_binding" {
  yaml_body = templatefile(
    "${path.module}/templates/target_group_binding.yaml",
    {
      target_group_arn  = var.target_group_arn
      target_group_name = local.target_group_name

      namespace    = var.namespace
      ingress_name = var.ingress_name
      service_name = var.service_name
      service_port = tostring(var.service_port)
    }
  )
}
