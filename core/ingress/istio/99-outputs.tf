output "endpoint" {
  value       = var.ingress_service_type == "LoadBalancer" ? data.aws_lb.istio_ingress[0].dns_name : null
  description = "LoadBalancer DNS name."
}
