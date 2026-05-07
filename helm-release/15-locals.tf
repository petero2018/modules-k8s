locals {
  ssm_values = {
    for name in keys(var.set_sensitive_values_from_ssm) : name => data.aws_ssm_parameter.sensitive[name].value
  }
  helm_config = {
    name             = var.name
    description      = var.description
    repository       = var.repository
    repo_path        = var.repo_path
    chart            = var.chart
    version          = var.chart_version
    timeout          = var.timeout
    values           = var.values
    create_namespace = var.create_namespace
    namespace        = var.namespace
    reset_values     = var.reset_values
    force_update     = var.force_update
    wait             = var.wait
    enable_oci       = var.enable_oci
    value_files      = var.value_files
    # Additional Helm Config
    lint                       = try(var.additional_helm_config["lint"], false)
    repository_key_file        = try(var.additional_helm_config["repository_key_file"], "")
    repository_cert_file       = try(var.additional_helm_config["repository_cert_file"], "")
    repository_username        = try(var.additional_helm_config["repository_username"], "")
    repository_password        = try(var.additional_helm_config["repository_password"], "")
    verify                     = try(var.additional_helm_config["verify"], false)
    keyring                    = try(var.additional_helm_config["keyring"], "")
    disable_webhooks           = try(var.additional_helm_config["disable_webhooks"], false)
    reuse_values               = try(var.additional_helm_config["reuse_values"], false)
    recreate_pods              = try(var.additional_helm_config["recreate_pods"], false)
    cleanup_on_fail            = try(var.additional_helm_config["cleanup_on_fail"], false)
    max_history                = try(var.additional_helm_config["max_history"], 10)
    atomic                     = try(var.additional_helm_config["atomic"], false)
    skip_crds                  = try(var.additional_helm_config["skip_crds"], false)
    render_subchart_notes      = try(var.additional_helm_config["render_subchart_notes"], true)
    disable_openapi_validation = try(var.additional_helm_config["disable_openapi_validation"], false)
    wait_for_jobs              = try(var.additional_helm_config["wait_for_jobs"], false)
    dependency_update          = try(var.additional_helm_config["dependency_update"], false)
    replace                    = try(var.additional_helm_config["replace"], false)
    # Values
    set_values        = var.set_values
    set_string_values = var.set_string_values
    set_sensitive     = merge(var.set_sensitive_values, local.ssm_values)
  }
}
