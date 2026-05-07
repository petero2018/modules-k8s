output "endpoint" {
  value       = var.ingress_type == "powise-nlb" ? kubernetes_service.nlb[0].status[0].load_balancer[0].ingress[0].hostname : null
  description = "LoadBalancer address, in case of NLB pointing to the set of stable IPs (e.g. for use in external plan with blue/green proxies)."
}

output "acm_certificate_arn" {
  value       = var.acm_certificate_arn != null ? var.acm_certificate_arn : module.certificate[0].arn
  description = "ACM certificate ARN used on the load balancer."
}
