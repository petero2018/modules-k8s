output "service" {
  value       = kubernetes_service.squid.metadata[0].name
  description = "Name of the Squid service."
}
