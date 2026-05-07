output "gateway_name" {
  value       = kubectl_manifest.ingressgateway.name
  description = "Name of the istio ingress gateway kubernetes resource."
}

output "gateway_namespace" {
  value       = kubectl_manifest.ingressgateway.namespace
  description = "Namespace of the istio ingress gateway kubernetes resource."
}

output "gateway_reference" {
  value       = "${kubectl_manifest.ingressgateway.namespace}/${kubectl_manifest.ingressgateway.name}"
  description = "Istio gateway reference in a form of <namespace>/<gateway>."
}
