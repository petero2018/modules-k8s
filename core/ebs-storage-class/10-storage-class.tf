locals {
  # Annotations
  annotations = merge(var.default ? tomap({
    "storageclass.kubernetes.io/is-default-class" : "true"
    }) : tomap({}), tomap({
    terraform_module = "git@github.com:powise/terraform-modules//k8s/core/ebs-storage-class"
  }), var.annotations)

  # Mount Options
  mount_options = var.mount_options != null ? {
    mountOptions = var.mount_options
  } : {}

  # Parameters
  parameters_iops_gb = var.iops_per_gb != null ? {
    iopsPerGB = var.iops_per_gb
  } : {}
  parameters_auto_iops = var.iops_per_gb != null ? {
    allowAutoIOPSPerGBIncrease = var.auto_iops
  } : {}
  parameters_iops = var.iops != null ? {
    iops = var.iops
  } : {}
  parameters_throughput = var.throughput != null ? {
    throughput = var.throughput
  } : {}
  parameters_kms_key = var.kms_key != null ? {
    kmsKeyId = var.kms_key
  } : {}

  # Tags
  parameters_tags = {
    for i in range(length(var.tags)) : "tagSpecification_${i + 1}" => "${keys(var.tags)[i]}=${values(var.tags)[i]}"
  }
}

resource "kubectl_manifest" "storage_class" {
  yaml_body = yamlencode(merge({
    apiVersion = "storage.k8s.io/v1"
    kind       = "StorageClass"
    metadata = {
      name        = var.name
      labels      = var.labels
      annotations = local.annotations
    }
    provisioner          = "ebs.csi.aws.com"      # Amazon EBS CSI driver
    volumeBindingMode    = "WaitForFirstConsumer" # EBS volumes are AZ specific
    reclaimPolicy        = var.reclaim_policy
    allowVolumeExpansion = var.allow_volume_expansion
    parameters = merge({
      "csi.storage.k8s.io/fstype" : var.file_system,
      type : var.volume_type
      encrypted : tostring(var.encrypted)
      }, local.parameters_iops_gb, local.parameters_auto_iops,
      local.parameters_iops, local.parameters_throughput,
    local.parameters_kms_key, local.parameters_tags)
  }, local.mount_options))
}
