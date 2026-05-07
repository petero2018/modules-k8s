resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"

    labels = merge({
      "app.kubernetes.io/name" : "aws-auth",
    }, local.labels)
  }

  data = {
    mapRoles = yamlencode([
      for role in concat(var.roles,
        # Worker Roles
        [for worker_role_name in var.worker_role_names :
          {
            role     = worker_role_name
            username = "system:node:{{EC2PrivateDNSName}}"
            groups   = ["system:bootstrappers", "system:nodes"]
          }
        ],
        [
          # System Roles
          {
            role     = "AdminRole"
            username = "admin"
            groups   = ["system:masters"]
          },
          {
            role     = "TerraformRole"
            username = "admin"
            groups   = ["system:masters"]
          },
          {
            role     = "CiCdRole"
            username = "cicd"
            groups   = ["system:masters"]
          }
        ]) : {
        rolearn : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${role.role}"
        username : role.username
        groups : role.groups
      }
    ])
  }
}
