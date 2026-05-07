module "deployment" {
  source = "git@github.com:powise/terraform-modules//k8s/simple-deployment?ref=simple-deployment-2.10.5"

  eks_cluster = var.eks_cluster

  name                   = "kubecost-statsd-exporter"
  namespace              = var.namespace
  environment            = var.environment
  aws_region             = var.aws_region
  app_image_repo         = "567716553783.dkr.ecr.us-east-1.amazonaws.com/kubecost-statsd-exporter"
  app_image_tag          = var.app_image_tag
  image_pull_policy      = "Always"
  enable_statsd_exporter = true

  backend_port  = var.backend_port
  backend_https = false

  liveness_probes = {
    "main" : { port = var.backend_port, path = "/_health/live", tls = false },
  }
  readiness_probes = {
    "main" : { port = var.backend_port, path = "/_health/ready", tls = false },
  }

  env = {
    "LABEL" : var.label,
    "ENV" : var.environment,
    "KUBECOST_URL" : var.kubecost_url,
    "STATSD_HOST" : var.statsd_host,
    "STATSD_PORT" : var.statsd_port,
  }

  requests = { cpu = "0.2", memory = "128Mi", ephemeral-storage = null }

  limits = { cpu = "0.5", memory = "256Mi", ephemeral-storage = null }

  tags = var.tags

}
