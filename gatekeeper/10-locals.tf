locals {
  sync_config = length(var.config_sync_data) > 0 ? {
    sync = {
      syncOnly = var.config_sync_data
    }
  } : {}
  match_config = length(var.config_match_data) > 0 ? {
    match = var.config_match_data
  } : {}

  config_spec_data = merge(local.match_config, local.sync_config)
}
