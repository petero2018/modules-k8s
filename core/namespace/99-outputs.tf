output "namespace" {
  value       = kubernetes_namespace.core.metadata[0].name
  description = "Name of the provisioned namespace."
}
