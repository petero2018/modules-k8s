locals {
  container_prefix = "/var/log/containers"
  # Add Container Prefix
  container_groups = {
    for name, containers in var.container_groups : name =>
    [for container in containers : "${local.container_prefix}/${container}*"]
  }
  dataplane_containers = [for container in var.dataplane_containers : "${local.container_prefix}/${container}*"]
  dataplane_containers_ignore = [
    for container in var.dataplane_container_ignore : "${local.container_prefix}/${container}*"
  ]
  # Get Exclude App Paths
  exclude_app_containers = concat(
    flatten([for name, containers in local.container_groups : containers]),
    local.dataplane_containers,
    [for container in var.application_ignore : "${local.container_prefix}/${container}*"]
  )
  # Host logs
  host_logs = var.host_logs_enabled ? var.host_logs : {}

  # Generate Inputs template
  inputs_template = templatefile("${path.module}/templates/inputs.yaml", {
    APPLICATION_TAG             = var.application_tag
    APPLICATION_EXCLUDE         = join(", ", local.exclude_app_containers)
    CONTAINER_PARSER            = var.container_config.parser
    CONTAINER_MEM_BUF_LIMIT     = var.container_config.mem_buf_limit
    CONTAINER_SKIP_LONG_LINES   = var.container_config.skip_long_lines
    CONTAINER_REFRESH_INTERVAL  = var.container_config.refresh_interval
    CONTAINER_ROTATE_WAIT       = var.container_config.rotate_wait
    CONTAINER_GROUPS            = { for name, containers in local.container_groups : name => join(", ", containers) }
    DATAPLANE_ENABLED           = var.dataplane_logs_enabled
    DATAPLANE_TAG               = var.dataplane_tag
    DATAPLANE_CONTAINERS        = join(", ", local.dataplane_containers)
    DATAPLANE_CONTAINERS_IGNORE = join(", ", local.dataplane_containers_ignore)
    HOST_ENABLED                = var.host_logs_enabled
    HOST_LOGS                   = local.host_logs
    HOST_TAG_PREFIX             = var.host_config.tag_prefix
    HOST_PARSER                 = var.host_config.parser
    HOST_MEM_BUF_LIMIT          = var.host_config.mem_buf_limit
    HOST_SKIP_LONG_LINES        = var.host_config.skip_long_lines
    HOST_REFRESH_INTERVAL       = var.host_config.refresh_interval
    SYSTEMD_ENABLED             = var.systemd_logs_enabled
    SYSTEMD_TAG                 = var.systemd_tag
    SYSTEMD_UNITS               = var.systemd_units
  })
  # Generate Parsers template
  parsers_template = templatefile("${path.module}/templates/parsers.yaml", {
    PARSERS = var.parsers
  })
  # Generate Filters template
  filters_template = templatefile("${path.module}/templates/filters.yaml", {
    # AWS Metadata
    AWS_METADATA_ENABLED  = var.aws_metadata_enabled
    AWS_IMDS_VERSION      = var.aws_metadata_config.imds_version
    AWS_AZ                = var.aws_metadata_config.az
    AWS_EC2_INSTANCE_ID   = var.aws_metadata_config.ec2_instance_id
    AWS_EC2_INSTANCE_TYPE = var.aws_metadata_config.ec2_instance_type
    AWS_PRIVATE_IP        = var.aws_metadata_config.private_ip
    AWS_AMI_ID            = var.aws_metadata_config.ami_id
    AWS_ACCOUNT_ID        = var.aws_metadata_config.account_id
    AWS_HOSTNAME          = var.aws_metadata_config.hostname
    AWS_VPC_ID            = var.aws_metadata_config.vpc_id
    # Kubernetes
    KUBERNETES_METADATA_ENABLED = var.kubernetes_metadata_enabled
    KUBERNETES_LABELS           = var.kubernetes_metadata_config.labels
    KUBERNETES_ANNOTATIONS      = var.kubernetes_metadata_config.annotations
    # Tags
    APPLICATION_TAG  = var.application_tag
    CONTAINER_GROUPS = { for name, containers in local.container_groups : name => join(", ", containers) }
    DATAPLANE_TAG    = var.dataplane_tag
    SYSTEMD_TAG      = var.systemd_tag
    # Static fields
    STATIC_FIELDS = var.static_fields
    # Flags
    DATAPLANE_ENABLED = var.dataplane_logs_enabled
    SYSTEMD_ENABLED   = var.systemd_logs_enabled
  })
  # Generate Outputs template
  outputs_template = templatefile("${path.module}/templates/outputs.yaml", {
    AWS_REGION = var.aws_region
    # Debug Output
    DEBUG_OUTPUT = var.debug_output_enabled
    # S3 Output
    S3_ENABLED     = var.s3_output_enabled
    S3_BUCKET      = var.s3_bucket
    S3_FILE_SIZE   = var.s3_file_size
    S3_KEY_PREFIX  = var.s3_key_prefix
    S3_KEY_FORMAT  = var.s3_key_format
    S3_COMPRESSION = var.s3_compression
    # Kafka Output
    KAFKA_ENABLED  = var.kafka_output_enabled
    KAFKA_BROKERS  = var.kafka_brokers
    KAFKA_TOPIC    = var.kafka_topic
    KAFKA_USERNAME = var.kafka_username
    KAFKA_PASSWORD = var.kafka_password
    # OpenSearch Output
    OPENSEARCH_ENABLED = var.opensearch_output_enabled
    OPENSEARCH_HOST    = var.opensearch_host
    OPENSEARCH_INDEX   = var.opensearch_index
    # Tags
    APPLICATION_TAG  = var.application_tag
    CONTAINER_GROUPS = { for name, containers in local.container_groups : name => join(", ", containers) }
    HOST_TAG_PREFIX  = var.host_config.tag_prefix
    SYSTEMD_TAG      = var.systemd_tag
    DATAPLANE_TAG    = var.dataplane_tag
    # Flags
    DATAPLANE_ENABLED = var.dataplane_logs_enabled
    HOST_ENABLED      = var.host_logs_enabled
    SYSTEMD_ENABLED   = var.systemd_logs_enabled
  })
  # Generate Service template
  service_template = file("${path.module}/templates/service.yaml")

  # Generate unified template
  template = yamlencode({
    "config" = {
      "service"       = yamldecode(local.service_template)["config"]["service"]
      "inputs"        = yamldecode(local.inputs_template)["config"]["inputs"]
      "filters"       = yamldecode(local.filters_template)["config"]["filters"]
      "outputs"       = yamldecode(local.outputs_template)["config"]["outputs"]
      "customParsers" = yamldecode(local.parsers_template)["config"]["customParsers"]
    }
  })
}
