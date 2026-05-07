module "launch_template" {
  count = var.use_launch_template && var.create_launch_template ? 1 : 0

  source = "../../../eks/core/workers/launch-template"

  launch_template_name = var.launch_template_name != null ? var.launch_template_name : "karpenter-${var.eks_cluster}-${var.provisioner_name}"

  platform                               = var.platform
  architecture                           = var.architecture
  gpu_support                            = var.gpu_support
  key_name                               = var.key_name
  k8s_version                            = var.k8s_version
  ami_id                                 = var.ami_id
  ebs_optimized                          = var.ebs_optimized
  cluster_security_group_id              = var.cluster_security_group_id
  workers_security_group_id              = var.workers_security_group_id
  additional_vpc_security_group_ids      = var.additional_vpc_security_group_ids
  launch_template_default_version        = var.launch_template_default_version
  update_launch_template_default_version = var.update_launch_template_default_version
  block_device_mappings                  = var.block_device_mappings
  spot_enabled                           = var.use_spot
  spot_max_price                         = var.spot_max_price
  enable_monitoring                      = var.enable_monitoring
  launch_template_tags = merge({
    "karpenter.sh/discovery" : var.eks_cluster
  }, var.launch_template_tags)
  instance_profile_arn = var.instance_profile_arn

  enable_bootstrap_user_data = var.enable_bootstrap_user_data
  cluster_name               = var.eks_cluster
  cluster_endpoint           = var.eks_cluster_endpoint
  cluster_auth_base64        = var.eks_cluster_auth_base64
  cluster_service_ipv4_cidr  = var.eks_cluster_service_ipv4_cidr
  pre_bootstrap_user_data    = var.pre_bootstrap_user_data
  post_bootstrap_user_data   = var.post_bootstrap_user_data
  bootstrap_extra_args       = var.bootstrap_extra_args
  user_data_template_path    = var.user_data_template_path
  registry_mirrors           = var.registry_mirrors

  tags = merge({
    "karpenter.sh/discovery" : var.eks_cluster
  }, local.tags)
}
