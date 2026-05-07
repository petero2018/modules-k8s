locals {
  template_file = var.template_file != "" ? var.template_file : "${path.module}/templates/values-eks-cost-monitoring.yaml"
  values = [
    templatefile(local.template_file,
      {
        prometheus_enabled = var.prometheus_enabled,
        frontend_memory    = var.frontend_memory,
        model_memory       = var.model_memory,
      }
    ),
  ]
}
