locals {
  datadog_tags = concat(var.custom_tags,
    var.eks_cluster != null ? ["kube_cluster:${var.eks_cluster}"] : [],
    var.environment != null ? ["kube_environment:${var.environment}"] : [],
    var.region != null ? ["region:${var.region}"] : [],
    var.kube_status != null ? ["kube_status:${var.kube_status}"] : [],
    var.product != null ? ["product:${var.product}"] : []
  )

  agent_image_config = var.use_custom_image ? {
    repository = "567716553783.dkr.ecr.us-east-1.amazonaws.com/infra/datadog/agent"
    } : {
    repository = "gcr.io/datadoghq/agent"
  }

  # Transform the variable into a map of {replica host} => {replica id, cluster info}
  clickhouse_replicas = merge([
    for cluster in var.clickhouse_clusters : {
      for index, replica_host in cluster.replica_hosts : replica_host => {
        replica_id = index
        cluster    = cluster
      }
    }
  ]...)

  values = [
    var.template_file != "" ? templatefile(var.template_file, var.template_values) :
    yamlencode({
      datadog = {
        clusterName       = var.eks_cluster
        site              = var.datadog_site
        tags              = local.datadog_tags
        loglevel          = var.log_level
        podLabelsAsTags   = var.pod_labels_as_tags
        checksCardinality = var.datadog_checks_cardinality
        otlp = {
          receiver = {
            protocols = {
              http = {
                enabled = true
              }
            }
          }
        }
        dogstatsd = {
          useHostPort = true
        }
        apm = {
          enabled = var.enable_apm
        }
        logs = {
          enabled             = var.enable_logs
          containerCollectAll = var.enable_logs
        }
        processAgent = {
          enabled           = var.enable_process_agent
          processCollection = var.enable_process_agent
        }
        env = [
          {
            name  = "DD_EC2_PREFER_IMDSV2"
            value = true
          },
          {
            name  = "DD_OTLP_CONFIG_TRACES_SPAN_NAME_AS_RESOURCE_NAME"
            value = true
          },
          {
            name  = "DD_LOGS_CONFIG_USE_HTTP" # Necessary to use Datadog VPC private endpoints
            value = true
          }
        ]
      }
      clusterAgent = {
        enabled = true
        metricsProvider = {
          enabled = true
          # clusterAgent.metricsProvider.useDatadogMetrics
          # Enable usage of DatadogMetric CRD to autoscale on arbitrary Datadog queries
          useDatadogMetrics = true
        }
        confd = merge(
          length(var.msk_cluster_arns) > 0 ? {
            "amazon_msk.yaml" = yamlencode({
              cluster_check = true
              instances = [for arn in var.msk_cluster_arns : {
                use_openmetrics = true
                cluster_arn     = arn
              }]
            })
          } : {},
          length(var.opensearch_urls) > 0 ? {
            "elastic.yaml" = yamlencode({
              cluster_check = true
              instances = [for config in var.opensearch_urls : merge({
                cluster_stats = true
                pshard_stats  = true
                index_stats   = true
                aws_region    = coalesce(config.region, var.region)
                url           = config.url
                }, config.auth_type != null ? {
                auth_type = config.auth_type
              } : {})]
            })
          } : {},
        )
        advancedConfd = merge(
          length(local.clickhouse_replicas) > 0 ? {
            "clickhouse.d" = {
              "conf.yaml" = yamlencode({
                cluster_check = true
                init_config   = {}
                instances = [for replica_host, info in local.clickhouse_replicas : {
                  server          = replica_host
                  port            = info.cluster.port
                  username        = info.cluster.username
                  password        = info.cluster.password
                  connect_timeout = 10
                  read_timeout    = 10
                  compression     = "lz4"
                  tls_verify      = true
                  verify          = true
                  tags = concat(local.datadog_tags, [
                    "clickhouse_cluster:${info.cluster.name}",
                    "replica:${info.replica_id}",
                  ])
                }]
              })
            }
          } : {},
        )
        envDict = {
          DD_EXTERNAL_METRICS_PROVIDER_MAX_AGE = var.dd_external_metrics_provider_max_age
        }
      }
      agents = {
        rbac = {
          serviceAccountAnnotations = {
            "eks.amazonaws.com/role-arn" = module.agent_role.irsa_iam_role_arn
          }
        }
        tolerations = var.agent_tolerations
        image       = local.agent_image_config
      }
    })
  ]
}
