data "aws_eks_cluster" "current" {
  name = var.eks_cluster
}

data "aws_eks_cluster_auth" "current" {
  name = var.eks_cluster
}

resource "null_resource" "delete_default" {
  count = var.delete_default ? 1 : 0

  triggers = {
    body = aws_eks_addon.ebs_csi_driver.id
  }

  provisioner "local-exec" {
    environment = {
      CLUSTER_ENDPOINT = data.aws_eks_cluster.current.endpoint
      CLUSTER_CA       = data.aws_eks_cluster.current.certificate_authority[0].data
      CLUSTER_TOKEN    = data.aws_eks_cluster_auth.current.token
    }
    command = format("%s/scripts/delete.sh", path.module)
  }
}
