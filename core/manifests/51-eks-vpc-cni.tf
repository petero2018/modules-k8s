# this is needed because of this issue: https://github.com/aws/eks-charts/issues/57
# and the solution implemented here is based on these:
# https://github.com/aws/eks-charts/issues/57#issuecomment-588983667
# https://github.com/aws/eks-charts/tree/master/stable/aws-vpc-cni#adopting-the-existing-aws-node-resources-in-an-eks-cluster
resource "null_resource" "import_aws_vpc_cni_plugin" {
  count = var.enable_security_group_policies ? 1 : 0

  provisioner "local-exec" {
    environment = {
      CLUSTER_ENDPOINT = data.aws_eks_cluster.current.endpoint
      CLUSTER_CA       = data.aws_eks_cluster.current.certificate_authority[0].data
      CLUSTER_TOKEN    = data.aws_eks_cluster_auth.current.token
    }
    command = format("%s/scripts/import-aws-node.sh", path.module)
  }
}

module "aws_vpc_cni" {
  source = "git@github.com:powise/terraform-modules//k8s/helm-release?ref=helm-release-0.3.1"

  count = var.enable_security_group_policies ? 1 : 0

  name = "aws-vpc-cni"

  namespace = "kube-system"

  repository    = "https://aws.github.io/eks-charts"
  chart         = "aws-vpc-cni"
  chart_version = var.vpc_cni_chart_version

  set_values = {
    "originalMatchLabels" : true
    "crd.create" : false
    "init.env.DISABLE_TCP_EARLY_DEMUX" : var.enable_security_group_policies
    "env.ENABLE_POD_ENI" : var.enable_security_group_policies
  }

  depends_on = [null_resource.import_aws_vpc_cni_plugin]
}

resource "null_resource" "drain_nodes_from_cluster" {
  count = var.enable_security_group_policies ? 1 : 0

  provisioner "local-exec" {
    environment = {
      CLUSTER_ENDPOINT = data.aws_eks_cluster.current.endpoint
      CLUSTER_CA       = data.aws_eks_cluster.current.certificate_authority[0].data
      CLUSTER_TOKEN    = data.aws_eks_cluster_auth.current.token
    }
    command = format("%s/scripts/drain-nodes.sh", path.module)
  }

  depends_on = [module.aws_vpc_cni]
}
