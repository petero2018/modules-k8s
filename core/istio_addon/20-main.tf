# Workaround to avoid using a data block to generate a for_each
# See https://github.com/gavinbunney/terraform-provider-kubectl/issues/141
locals {
  crds_split_doc  = split("---", file("${path.module}/manifests/${var.addon_name}.yaml"))
  crds_valid_yaml = [for doc in local.crds_split_doc : doc if try(yamldecode(doc).metadata.name, null) != null]
  crds_dict       = { for doc in toset(local.crds_valid_yaml) : "${yamldecode(doc).kind}_${yamldecode(doc).metadata.name}" => doc }
}

resource "kubectl_manifest" "addon" {
  for_each  = local.crds_dict
  yaml_body = each.value
}
