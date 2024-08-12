variable "prefix" {
  description = "Project prefix for naming and tags."
  type        = string
}

variable "rg_name" {
  type = string
  description = "Resource group name."
  default = ""
}

variable "rg_location" {
  type = string
  description = "Resource group location."
  default = ""
}

variable network_cidr {
  type        = list(string)
  description = "IP CIDR for network."
}

variable "subnets" {
  type = list(object({
    name = string
    ip_cidr = string
  }))
  description = "Name and CIDR for subnet creating."
  default = []
}