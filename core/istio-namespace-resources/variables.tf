variable "name" {
  type = string

  description = "Name of the namespace."
}

variable "authority_domain" {
  type = string

  default = null

  description = "Domain name to append to non-FQDN Host/Authority request headers (via EnvoyFilter)."
}
