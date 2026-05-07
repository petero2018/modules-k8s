data "http" "volume_snapshot_class" {
  url = "https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/${var.csi_snapshotter_version}/client/config/crd/snapshot.storage.k8s.io_volumesnapshotclasses.yaml"
}

resource "kubectl_manifest" "volume_snapshot_class" {
  yaml_body = data.http.volume_snapshot_class.body
}

data "http" "volume_snapshot_contents" {
  url = "https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/${var.csi_snapshotter_version}/client/config/crd/snapshot.storage.k8s.io_volumesnapshotcontents.yaml"
}

resource "kubectl_manifest" "volume_snapshot_contents" {
  yaml_body = data.http.volume_snapshot_contents.body
}

data "http" "volume_snapshots" {
  url = "https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/${var.csi_snapshotter_version}/client/config/crd/snapshot.storage.k8s.io_volumesnapshots.yaml"
}

resource "kubectl_manifest" "volume_snapshots" {
  yaml_body = data.http.volume_snapshots.body
}
