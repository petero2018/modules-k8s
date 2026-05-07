locals {
  template_file = var.template_file != "" ? var.template_file : "${path.module}/templates/filebeat.yaml"

  values = [
    templatefile(
      local.template_file,
      merge(
        var.template_values,
        {
          drop_fields   = var.drop_fields
          drop_services = var.drop_services
        }
      ),
    )
  ]
}
