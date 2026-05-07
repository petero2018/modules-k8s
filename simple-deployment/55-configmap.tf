resource "kubernetes_config_map" "files" {
  metadata {
    name      = "${var.name}-files"
    namespace = local.namespace

    labels = local.labels
  }

  data = {
    for file_name, file_content in var.files :
    file_name => file_content
  }

  binary_data = {
    for file_name, file_content in var.binary_files :
    file_name => file_content
  }
}
