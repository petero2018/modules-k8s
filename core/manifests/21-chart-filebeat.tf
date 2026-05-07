module "filebeat" {
  source = "git@github.com:powise/terraform-modules//k8s/helm-release?ref=helm-release-0.3.1"

  name = "filebeat"

  namespace        = "filebeat"
  create_namespace = true

  repository    = "https://helm.elastic.co"
  chart         = "filebeat"
  chart_version = var.filebeat_chart_version

  values = [
    templatefile(
      "${path.module}/templates/filebeat.yaml",
      {
        eks_cluster                 = var.eks_cluster,
        environment                 = var.environment,
        kube_status                 = var.kube_status,
        product                     = var.product,
        logstash_redis_host         = var.logstash_redis_host,
        enable_core_components_logs = var.enable_core_components_logs,
      }
    ),
  ]

  timeout = var.daemonset_helm_timeout
}
