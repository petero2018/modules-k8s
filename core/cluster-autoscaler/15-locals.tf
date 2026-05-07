locals {
  cluster_autoscaler_template_file = var.cluster_autoscaler_template_file != "" ? var.cluster_autoscaler_template_file : "${path.module}/templates/cluster-autoscaler.yaml"

  cluster_autoscaler_values = [templatefile(local.cluster_autoscaler_template_file,
    merge(var.cluster_autoscaler_template_values, {
      eks_cluster  = var.eks_cluster,
      iam_role_arn = module.cluster_autoscaler_role.arn,
      config       = var.cluster_autoscaler_config,
  }))]
}
