resource "null_resource" "drain_nodes_from_cluster" {

  provisioner "local-exec" {
    environment = {
      CLUSTER_ENDPOINT = data.aws_eks_cluster.current.endpoint
      CLUSTER_CA       = data.aws_eks_cluster.current.certificate_authority[0].data
      CLUSTER_TOKEN    = data.aws_eks_cluster_auth.current.token
    }
    command = format("%s/scripts/drain-pods.sh", path.module)
  }

  depends_on = [module.cilium]
}
