module "cluster_autoscaler" {
  source = "git@github.com:powise/terraform-modules//k8s/helm-release?ref=helm-release-0.3.1"

  count = var.enable_cluster_autoscaler ? 1 : 0

  name = "cluster-autoscaler"

  namespace        = "kube-system"
  create_namespace = false

  repository    = "https://kubernetes.github.io/autoscaler"
  chart         = "cluster-autoscaler"
  chart_version = var.aws_cluster_autoscaler_chart_version

  values = [
    templatefile(
      "${path.module}/templates/cluster-autoscaler.yaml",
      {
        image_tag    = var.aws_cluster_autoscaler_image_tag
        eks_cluster  = var.eks_cluster,
        iam_role_arn = module.cluster_autoscaler_role[0].arn,
        config       = var.cluster_autoscaler_config,
      }
    ),
  ]


}

module "cluster_autoscaler_role" {
  source = "git@github.com:powise/terraform-modules//eks/oidc-role?ref=oidc-role-0.0.1"

  count = var.enable_cluster_autoscaler ? 1 : 0

  eks_cluster = var.eks_cluster

  iam_role_name       = "eks-cluster-autoscaler-${var.eks_cluster}-${data.aws_region.current.name}"
  iam_policy_document = file("${path.module}/files/cluster-autoscaler-iam-policy.json")

  namespace       = "kube-system"
  service_account = "cluster-autoscaler-aws-cluster-autoscaler"
}

module "overprovisioning" {
  source = "git@github.com:powise/terraform-modules//k8s/overprovisioning?ref=overprovisioning-0.0.7"

  for_each = { for overprovisioning_config in var.overprovisioning_configs : overprovisioning_config.name => overprovisioning_config }

  name                = each.value.name
  node_group_name     = each.value.node_group_name
  namespace           = kubernetes_namespace.overprovisioning.metadata[0].name
  priority_class_name = kubernetes_priority_class.overprovisioning.metadata[0].name

  # Proportional autoscaler scales per CPU in the cluster so this should always be ~1 CPU for the "percentage" of headroom to make sense
  # Setting exactly 1 CPU would take too much space on 2 CPU nodes due to nodes not exactly having 2000m but a bit less
  cpu_per_pod = "750m"
}

module "overprovisioning_proportional_autoscaler" {
  source = "git@github.com:powise/terraform-modules//k8s/helm-release?ref=helm-release-0.3.1"

  for_each = { for overprovisioning_config in var.overprovisioning_configs : overprovisioning_config.name => overprovisioning_config }

  name = "prop-autoscaler-${each.value.name}"

  namespace        = kubernetes_namespace.overprovisioning.metadata[0].name
  create_namespace = false

  repository    = "https://kubernetes-sigs.github.io/cluster-proportional-autoscaler"
  chart         = "cluster-proportional-autoscaler"
  chart_version = "1.0.0"

  set_values = {
    "nameOverride" : each.value.name,

    "options.target" : "deployment/${each.value.name}",

    "config.linear.coresPerReplica" : tostring(ceil(100 / each.value.slack_pct)),
    "config.linear.min" : tostring(each.value.min_replicas),
    "config.linear.max" : tostring(each.value.max_replicas),

    "replicaCount" : "1",
  }
}

resource "kubernetes_priority_class" "overprovisioning" {
  metadata {
    name = "overprovisioning"
  }

  value          = -1
  global_default = false

  description = "Priority class used for cluster overprovisioner pods"
}

resource "kubernetes_namespace" "overprovisioning" {
  metadata {
    name = "overprovisioning"

    labels = {
      istio-injection = "disabled"
    }
  }
}
