data "aws_eks_cluster" "current" {
  name = var.eks_cluster
}

data "aws_eks_cluster_auth" "current" {
  name = var.eks_cluster
}

resource "null_resource" "wait" {
  triggers = {
    body = var.wait_trigger
  }

  provisioner "local-exec" {
    environment = {
      CLUSTER_ENDPOINT = data.aws_eks_cluster.current.endpoint
      CLUSTER_CA       = data.aws_eks_cluster.current.certificate_authority[0].data
      CLUSTER_TOKEN    = data.aws_eks_cluster_auth.current.token
      NAMESPACE        = var.namespace
      NAME             = var.name
      TIMEOUT          = var.timeout
      RESOURCE         = var.resource
      JSON_PATH        = var.json_path
      EXPECTED_VALUE   = var.expected_value
      STEP_TIME        = var.step_time
      ERROR_MESSAGE    = var.error_message
    }
    command = format("%s/scripts/wait.sh", path.module)
  }
}
