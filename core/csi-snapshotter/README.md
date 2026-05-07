# CSI Snapshotter

[CSI Snapshotter](https://github.com/kubernetes-csi/external-snapshotter) resources to allow CSI drivers manage snapshots in the kubernetes cluster.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.7 |
| <a name="requirement_http"></a> [http](#requirement\_http) | >= 2.1.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.13.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_http"></a> [http](#provider\_http) | >= 2.1.0 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.13.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.default_volume_snapshot_class](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.snapshot_controller](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.snapshot_controller_rbac](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.volume_snapshot_class](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.volume_snapshot_contents](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.volume_snapshots](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [http_http.snapshot_controller](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.snapshot_controller_rbac](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.volume_snapshot_class](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.volume_snapshot_contents](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.volume_snapshots](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [kubectl_file_documents.snapshot_controller_rbac](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/file_documents) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_csi_snapshotter_version"></a> [csi\_snapshotter\_version](#input\_csi\_snapshotter\_version) | CSI Snapshotter version. | `string` | n/a | yes |
| <a name="input_default_class"></a> [default\_class](#input\_default\_class) | Creates a default volume snapshot class. | `bool` | `true` | no |
| <a name="input_default_class_labels"></a> [default\_class\_labels](#input\_default\_class\_labels) | Labels to add to the default volume snapshot class. | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
