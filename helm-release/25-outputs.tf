output "helm_config" {
  value       = local.helm_config
  description = "Helm Config to be used by GitOps tools."
}

output "app_version" {
  # For now app_version is only available when using Helm
  value       = try(helm_release.release[0].metadata[0].app_version, null)
  description = "The version of the app installed by the Helm chart."
}
