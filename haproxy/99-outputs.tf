output "service" {
  value       = kubernetes_service.haproxy.metadata[0].name
  description = "Name of the HAProxy service."
}
