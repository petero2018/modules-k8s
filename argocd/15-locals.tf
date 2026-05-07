locals {
  # Policies
  policies = join("\n", [
    for policy in flatten([
      for name, policies in var.roles : [
        for policy in policies : {
          role : name,
          resource : policy.resource,
          action : policy.action,
          object : policy.object
        }
      ]
    ]) : "      p, role:${policy.role}, ${policy.resource}, ${policy.action}, ${policy.object}, allow"
  ])

  # Okta Groups
  okta_groups = var.okta_enable ? join("\n", [
    for group, role in var.okta_groups : "      g, ${group}, role:${role}"
  ]) : ""
}
