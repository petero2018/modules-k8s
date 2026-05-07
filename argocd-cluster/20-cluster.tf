data "aws_eks_cluster" "remote" {
  name = var.cluster_name

  provider = aws.remote
}

resource "kubernetes_secret" "cluster" {
  metadata {
    name      = "argocd-cluster-${var.cluster_name}"
    namespace = var.namespace

    labels = merge(var.labels, {
      "environment"                    = var.environment
      "argocd.argoproj.io/secret-type" = "cluster"
    })
  }

  data = {
    name             = data.aws_eks_cluster.remote.id
    server           = data.aws_eks_cluster.remote.endpoint
    namespaces       = join(",", var.managed_namespaces)
    clusterResources = tostring(var.manage_cluster_resources)
    config = jsonencode({
      awsAuthConfig = {
        clusterName = data.aws_eks_cluster.remote.id
        roleARN     = aws_iam_role.argocd_remote_role.arn
      }
      tlsClientConfig = {
        caData = data.aws_eks_cluster.remote.certificate_authority[0].data
      }
    })
  }
}
