module "provisioner" {
  for_each = var.provisioners

  source = "../karpenter-provisioner"

  provisioner_name = each.key

  eks_cluster             = var.eks_cluster
  eks_cluster_endpoint    = var.eks_cluster_endpoint
  eks_cluster_auth_base64 = var.eks_cluster_auth_base64

  cluster_security_group_id = var.cluster_security_group_id
  workers_security_group_id = var.workers_security_group_id

  k8s_version = var.k8s_version

  seconds_after_empty   = coalesce(each.value.seconds_after_empty, 120)
  seconds_until_expired = each.value.seconds_until_expired

  use_spot             = coalesce(each.value.use_spot, false)
  instance_profile_arn = var.instance_profile_arn
  platform             = coalesce(each.value.platform, "bottlerocket")
  architecture         = coalesce(each.value.architecture, "amd64")
  gpu_support          = coalesce(each.value.gpu_support, false)
  key_name             = each.value.key_name
  requirements         = each.value.requirements

  taints      = coalesce(each.value.taints, [])
  node_labels = coalesce(each.value.node_labels, {})
  node_tags   = coalesce(each.value.node_tags, {})

  startup_taints = var.startup_taints

  limit_cpu    = coalesce(each.value.limit_cpu, "1000")
  limit_memory = coalesce(each.value.limit_memory, "1000Gi")

  registry_mirrors = var.registry_mirrors

  block_device_mappings = coalesce(each.value.block_device_mappings, [])

  tags = var.tags

}
