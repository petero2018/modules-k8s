resource "kubectl_manifest" "target_group_binding" {
  for_each = var.target_groups

  yaml_body = templatefile(
    "${path.module}/templates/target_group_binding.yaml",
    {
      crd              = local.targetgroupbinding_crd
      name             = each.key
      service_name     = var.service_name
      namespace        = var.namespace
      port             = each.value.port
      target_group_arn = each.value.arn
    }
  )
}
