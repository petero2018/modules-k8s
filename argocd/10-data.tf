# In order to compute only once
resource "null_resource" "encrypted_admin_password" {
  triggers = {
    password = bcrypt(var.admin_password)
  }

  lifecycle {
    ignore_changes = [triggers]
  }
}
