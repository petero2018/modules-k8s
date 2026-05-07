locals {
  ssm_data   = kubernetes_secret.ssm.data != null ? kubernetes_secret.ssm.data : { "NOSECRETS" : "true" }
  files_data = kubernetes_config_map.files.data != null ? kubernetes_config_map.files.data : { "NOFILES" : "true" }

  secret_ssm_keys_sha256   = sha256(join("", (sort(keys(local.ssm_data)))))
  secret_ssm_values_sha256 = sha256(join("", (sort(values(local.ssm_data)))))

  configmap_files_keys_sha256   = sha256(join("", (sort(keys(local.files_data)))))
  configmap_files_values_sha256 = sha256(join("", (sort(values(local.files_data)))))

  image = "${var.app_image_repo}:${var.app_image_tag}"
}

resource "kubernetes_deployment" "app" {
  #checkov:skip=CKV_K8S_8:Optional
  #checkov:skip=CKV_K8S_9:Optional
  #checkov:skip=CKV_K8S_14:Optional
  #checkov:skip=CKV_K8S_16:YAGNI
  #checkov:skip=CKV_K8S_22:YAGNI
  #checkov:skip=CKV_K8S_28:Optional
  #checkov:skip=CKV_K8S_29:YAGNI here
  #checkov:skip=CKV_K8S_30:Optional
  #checkov:skip=CKV_K8S_35:YAGNI
  #checkov:skip=CKV_K8S_37:Optional

  metadata {
    name      = var.name
    namespace = local.namespace

    labels = local.deployment_labels
  }

  spec {
    replicas = var.replicas

    strategy {
      type = var.deployment_strategy
      # Set rolling_update params if selected
      dynamic "rolling_update" {
        for_each = var.deployment_strategy == "RollingUpdate" ? toset([1]) : toset([])

        content {
          max_unavailable = 0
        }
      }
    }

    selector {
      match_labels = local.labels
    }

    template {
      metadata {
        labels = local.deployment_labels

        annotations = {
          "sha256/secret-ssm"           = "${local.secret_ssm_keys_sha256}.${local.secret_ssm_values_sha256}"
          "sha256/configmap-files"      = "${local.configmap_files_keys_sha256}.${local.configmap_files_values_sha256}"
          "karpenter.sh/do-not-disrupt" = var.disable_disruption
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

        dynamic "affinity" {
          for_each = var.enable_multi_az_deployment ? [1] : []
          content {
            pod_anti_affinity {
              preferred_during_scheduling_ignored_during_execution {
                pod_affinity_term {
                  label_selector {
                    match_labels = local.deployment_labels
                  }
                  topology_key = "topology.kubernetes.io/zone"
                }
                weight = 100
              }
            }
          }
        }

        node_selector = var.arch_selection ? {
          "kubernetes.io/arch" = var.deploy_arch
        } : null

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
          image = local.image

          command = var.command
          args    = var.args

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
            name  = "DOCKER_HOST"
            value = var.enable_dind ? "tcp://localhost:2375" : ""
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

          image_pull_policy = var.image_pull_policy

          port {
            name           = substr(var.name, 0, 15)
            container_port = var.backend_port
          }

          resources {
            requests = {
              cpu               = var.requests.cpu
              memory            = var.requests.memory
              ephemeral-storage = var.requests.ephemeral-storage
            }

            limits = {
              cpu               = var.limits.cpu
              memory            = var.limits.memory
              ephemeral-storage = var.limits.ephemeral-storage
            }
          }

          dynamic "readiness_probe" {
            for_each = var.readiness_probes

            content {
              http_get {
                port   = readiness_probe.value.port
                path   = readiness_probe.value.path
                scheme = readiness_probe.value.tls ? "HTTPS" : "HTTP"
              }
            }
          }

          dynamic "liveness_probe" {
            for_each = var.liveness_probes

            content {
              http_get {
                port   = liveness_probe.value.port
                path   = liveness_probe.value.path
                scheme = liveness_probe.value.tls ? "HTTPS" : "HTTP"
              }
            }
          }

          volume_mount {
            name       = "files"
            mount_path = var.files_mount_path
            read_only  = true
          }

          volume_mount {
            name       = "secrets-ssm"
            mount_path = "/secrets/ssm"
            read_only  = true
          }

          volume_mount {
            name       = "shared"
            mount_path = var.shared_volume_path
            read_only  = false
          }

          dynamic "volume_mount" {
            for_each = var.shm_mem_enabled == "" ? [] : [1]
            content {
              name       = "dshm"
              mount_path = "/dev/shm"
            }
          }

          dynamic "volume_mount" {
            for_each = toset(var.custom_volumes)

            content {
              mount_path = volume_mount.value.mount_path
              name       = volume_mount.value.name
            }
          }
        }

        dynamic "container" {
          for_each = local.dind

          content {
            name  = container.key
            image = container.value

            env {
              name  = "DOCKER_TLS_CERTDIR"
              value = ""
            }

            resources {
              requests = {
                cpu               = var.dind_requests.cpu
                memory            = var.dind_requests.memory
                ephemeral-storage = var.dind_requests.ephemeral-storage
              }

              limits = {
                cpu               = var.dind_limits.cpu
                memory            = var.dind_limits.memory
                ephemeral-storage = var.dind_limits.ephemeral-storage
              }
            }
            security_context {
              privileged = true
            }

            volume_mount {
              name       = "dind"
              mount_path = "/var/lib/docker"
              read_only  = false
            }

            volume_mount {
              name       = "shared"
              mount_path = var.shared_volume_path
              read_only  = false
            }
          }
        }

        dynamic "container" {
          for_each = local.redis

          content {
            name  = container.key
            image = container.value

            volume_mount {
              name       = "redis"
              mount_path = "/data"
              read_only  = false
            }
          }
        }

        dynamic "container" {
          for_each = local.statsd_exporter

          content {
            name  = container.key
            image = container.value

            image_pull_policy = "IfNotPresent"

            env {
              name = "HOST_IP"
              value_from {
                field_ref {
                  api_version = "v1"
                  field_path  = "status.hostIP"
                }
              }
            }

            port {
              name           = "statsd"
              container_port = 9125
              protocol       = "UDP"
            }

            port {
              name           = "prometheus"
              container_port = 9102
              protocol       = "TCP"
            }

            resources {
              requests = {
                cpu    = "100m"
                memory = "128Mi"
              }

              limits = {
                cpu    = "150m"
                memory = "192Mi"
              }
            }
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

        dynamic "volume" {
          for_each = local.dind

          content {
            name = volume.key
            empty_dir {
            }
          }
        }

        dynamic "volume" {
          for_each = var.shm_mem_enabled == "" ? [] : [1]

          content {
            name = "dshm"
            empty_dir {
              medium     = "Memory"
              size_limit = var.shm_mem
            }
          }
        }

        dynamic "volume" {
          for_each = local.redis

          content {
            name = volume.key
            empty_dir {
            }
          }
        }

        dynamic "volume" {
          for_each = toset(var.custom_volumes)

          content {
            name = volume.value.name
            persistent_volume_claim {
              claim_name = volume.value.claim_name
            }
          }
        }

        volume {
          name = "shared"
          empty_dir {
          }
        }
      }
    }
  }

  depends_on = [kubernetes_secret.ssm, kubernetes_config_map.files]
}
