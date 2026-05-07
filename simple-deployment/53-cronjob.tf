resource "kubernetes_cron_job_v1" "cronjob" {
  for_each = var.cron_jobs

  metadata {
    name      = each.key
    namespace = local.namespace
  }

  spec {
    schedule = each.value.schedule

    job_template {
      metadata {
        name = each.key
      }

      spec {
        backoff_limit              = each.value.backoff_limit
        ttl_seconds_after_finished = each.value.ttl_seconds_after_finished

        template {
          metadata {
            labels = {
              app = var.name
            }
          }

          spec {
            service_account_name            = kubernetes_service_account.app.metadata[0].name
            automount_service_account_token = true

            security_context {
              fs_group = var.pod_security_context.fs_group
            }

            dynamic "image_pull_secrets" {
              for_each = toset(var.image_pull_secrets)

              content {
                name = image_pull_secrets.value
              }
            }

            node_selector = {
              "kubernetes.io/arch" = var.deploy_arch
            }

            dynamic "toleration" {
              for_each = local.tolerations
              content {
                key      = toleration.value.key
                operator = toleration.value.operator
                value    = toleration.value.value
                effect   = toleration.value.effect
              }
            }

            container {
              name  = var.name
              image = coalesce(each.value.image, local.image)

              command = each.value.command
              args    = each.value.args

              security_context {
                run_as_non_root = var.run_as_non_root
                run_as_group    = var.run_as_group # ISSUE: https://github.com/hashicorp/terraform-provider-kubernetes/issues/695
                run_as_user     = var.run_as_user
                capabilities {
                  add  = var.container_security_context.add_capabilities
                  drop = var.container_security_context.drop_capabilities
                }
              }

              dynamic "env" {
                for_each = var.env

                content {
                  name  = env.key
                  value = env.value
                }
              }

              dynamic "env" {
                for_each = var.env_from_field_ref

                content {
                  name = env.key
                  value_from {
                    field_ref {
                      api_version = env.value.api_version
                      field_path  = env.value.field_path
                    }
                  }
                }
              }

              env_from {
                secret_ref {
                  name = kubernetes_secret.ssm.metadata[0].name
                }
              }

              env {
                name = "HOST_IP"
                value_from {
                  field_ref {
                    api_version = "v1"
                    field_path  = "status.hostIP"
                  }
                }
              }

              volume_mount {
                name       = "secrets-ssm"
                mount_path = "/secrets/ssm"
                read_only  = true
              }

              volume_mount {
                name       = "files"
                mount_path = var.files_mount_path
                read_only  = true
              }
            }

            volume {
              name = "files"
              config_map {
                name = kubernetes_config_map.files.metadata[0].name
              }
            }

            volume {
              name = "secrets-ssm"
              secret {
                secret_name  = kubernetes_secret.ssm.metadata[0].name
                default_mode = var.default_mode_secrets
              }
            }

            restart_policy = each.value.restart_policy
          }
        }
      }
    }
  }

  depends_on = [kubernetes_secret.ssm, kubernetes_config_map.files]
}
