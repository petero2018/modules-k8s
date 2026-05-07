resource "kubectl_manifest" "default_volume_snapshot_class" {
  count = var.default_class ? 1 : 0

  yaml_body = yamlencode({
    apiVersion = "snapshot.storage.k8s.io/v1"
    kind       = "VolumeSnapshotClass"
    metadata = {
      name   = "csi-aws-vsc"
      labels = var.default_class_labels
      annotations = {
        "snapshot.storage.kubernetes.io/is-default-class" : "true"
      }
    }
    driver         = "ebs.csi.aws.com"
    deletionPolicy = "Delete"
  })

  depends_on = [
    kubectl_manifest.volume_snapshot_class
  ]
}
