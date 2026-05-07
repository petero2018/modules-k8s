output "istio_namespace" {
  value       = module.namespace.namespace
  description = "Namespace we deployed istio into."
}

output "istio_version" {
  value       = var.istio_version
  description = "istio chart version we installed in this module"
}

output "istio_charts_path" {
  value       = "${data.external.istio.result["path"]}/manifests/charts"
  description = "Local path to install istio charts from"
}
