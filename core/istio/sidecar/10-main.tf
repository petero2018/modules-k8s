resource "kubectl_manifest" "side_car" {
  yaml_body = templatefile(
    "${path.module}/templates/side-car.yaml",
    {
      namespace = var.namespace
      hosts     = var.hosts
      name      = var.name
    }
  )
}
