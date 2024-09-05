variable "enable_default_route_table_association" {
  description = "Variable that enable or disable auto accept attachments."
  type = bool
  default = true
}

variable "enable_default_route_table_propagation" {
  description = "Variable that enable or disable auto accept attachments."
  type = bool
  default = true
}

variable "enable_vpn_ecmp_support" {
  description = "Variable that enable or disable auto accept attachments."
  type = bool
  default = true
}

variable "enable_dns_support" {
  description = "Variable that enable or disable auto accept attachments."
  type = bool
  default = true
}

variable "enable_auto_accept_shared_attachments" {
  description = "Variable that enable or disable auto accept attachments."
  type = bool
  default = true
}

variable "enable_multicast_support" {
  description = "Variable that enable or disable auto accept attachments."
  type = bool
  default = false
}