data "http" "snapshot_controller_rbac" {
  url = "https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/${var.csi_snapshotter_version}/deploy/kubernetes/snapshot-controller/rbac-snapshot-controller.yaml"
}

data "kubectl_file_documents" "snapshot_controller_rbac" {
  content = data.http.snapshot_controller_rbac.body
}

resource "kubectl_manifest" "snapshot_controller_rbac" {
  for_each  = data.kubectl_file_documents.snapshot_controller_rbac.manifests
  yaml_body = each.value
}

data "http" "snapshot_controller" {
  url = "https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/${var.csi_snapshotter_version}/deploy/kubernetes/snapshot-controller/setup-snapshot-controller.yaml"
}

resource "kubectl_manifest" "snapshot_controller" {
  yaml_body = data.http.snapshot_controller.body
}
