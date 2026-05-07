output "namespace" {
  value       = var.namespace
  description = "Namespace where secrets were provisioned."
}

output "names" {
  value       = keys(var.secrets)
  description = "Names of the secrets provisioned."
}

output "fields" {
  value       = { for name, data in var.secrets : name => keys(data) }
  description = "Secret data fields referenced in { secret_name => [field1, field2 ... fieldN] } form."
}
