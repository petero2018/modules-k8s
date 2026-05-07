locals {
  # logstash config files
  logstash_yml = yamlencode({
    http = {
      host = "0.0.0.0"
    }
    log = {
      format = "json" # JSON log format
    }
    pipeline = merge(
      {
        ecs_compatibility = var.enable_ecs_compatibility
        batch = {
          size = var.pipeline_batch_size
        }
      },
      var.pipeline_workers != null ? {
        workers = var.pipeline_workers
    } : {})
  })
  pipelines_yml = yamlencode(
    [for pipeline in keys(var.pipelines) : {
      "pipeline.id" = trimsuffix(pipeline, ".conf")
      "path.config" = "/usr/share/logstash/pipeline/${pipeline}"
    }]
  )

  pipeline_config = { logstashPipeline = merge({ "logstash.conf" = "" }, var.pipelines) }
  pattern_config  = { logstashPattern = var.patterns }
  ports_config    = { extraPorts = [for port in var.ports : { name = port.name, containerPort = port.container_port }] }
  rbac_config = {
    rbac = {
      create             = true
      serviceAccountName = var.name
      serviceAccountAnnotations = var.enable_iam ? {
        "eks.amazonaws.com/role-arn" = module.irsa[0].irsa_iam_role_arn
      } : {}
    }
  }
  misc_confg = {
    replicas       = var.replicas
    maxUnavailable = var.max_unavailable
    image          = var.image_repository
    imageTag       = var.logstash_version

    logstashJavaOpts = var.java_opts
    resources = {
      requests = {
        cpu    = var.resource_requests.cpu
        memory = var.resource_requests.memory
      }
      limits = {
        cpu    = var.resource_limits.cpu
        memory = var.resource_limits.memory
      }
    }
  }
  service_config = length(var.ports) > 0 ? {
    service = {
      type = "ClusterIP"
      ports = [for port in var.ports : {
        name       = port.name
        port       = port.container_port
        targetPort = port.container_port
        protocol   = "TCP"
      }]
    }
  } : {}
  logstash_config = {
    logstashConfig = merge(
      { "logstash.yml" = local.logstash_yml },
      var.enable_multiple_pipeline_support ? { "pipelines.yml" = local.pipelines_yml } : {}
    )
  }
  datadog_config = {
    podAnnotations = {
      "ad.datadoghq.com/logstash.checks" = jsonencode({
        "logstash" = {
          "init_config" = {},
          "instances" = [
            {
              "url" = "http://%%host%%:9600"
            }
          ]
        }
      })
    }
  }

  values = [yamlencode(merge(
    local.pipeline_config,
    local.pattern_config,
    local.rbac_config,
    local.ports_config,
    local.misc_confg,
    local.service_config,
    local.logstash_config,
    local.datadog_config,
  ))]
}
