resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name  = var.eks_cluster
  addon_name    = "aws-ebs-csi-driver"
  addon_version = var.ebs_csi_version

  service_account_role_arn = module.ebs_csi_irsa.irsa_iam_role_arn

  configuration_values = var.configuration_values

  tags = local.tags

  depends_on = [
    module.ebs_csi_irsa
  ]
}
