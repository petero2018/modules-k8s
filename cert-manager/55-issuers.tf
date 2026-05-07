resource "kubectl_manifest" "cluster_issuer_letsencrypt_staging" {
  # Let's Encrypt staging issuer, used for testing purposes

  yaml_body = yamlencode({
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = "letsencrypt-staging"
    }
    spec = {
      acme = {
        server = "https://acme-staging-v02.api.letsencrypt.org/directory"
        email  = var.acme_email
        privateKeySecretRef = {
          name = "letsencrypt-staging"
        }
        solvers = [
          for zone in var.route53_zones : {
            selector = {
              dnsZones = [zone.domain]
            }
            dns01 = {
              route53 = {
                region       = var.aws_region
                hostedZoneID = zone.id
              }
            }
          }
        ]
      }
    }
  })

  depends_on = [module.release]
}

resource "kubectl_manifest" "cluster_issuer_letsencrypt_production" {
  # Main Let's Encrypt issuer

  yaml_body = yamlencode({
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = "letsencrypt-production"
    }
    spec = {
      acme = {
        server = "https://acme-v02.api.letsencrypt.org/directory"
        email  = var.acme_email
        privateKeySecretRef = {
          name = "letsencrypt-production"
        }
        solvers = [
          for zone in var.route53_zones : {
            selector = {
              dnsZones = [zone.domain]
            }
            dns01 = {
              route53 = {
                region       = var.aws_region
                hostedZoneID = zone.id
              }
            }
          }
        ]
      }
    }
  })

  depends_on = [module.release]
}
