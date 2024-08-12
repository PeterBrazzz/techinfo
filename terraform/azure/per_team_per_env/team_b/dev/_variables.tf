variable "prefix" {
  description = "Project prefix for naming and tags."
  type        = string
  default     = "team-b-dev"
}

variable "team" {
  description = "Name of the team."
  type        = string
  default     = "team-b"
}

variable location {
  type        = string
  default     = "West US"
  description = "Used region."
}

variable network_cidr {
  type        = list(string)
  description = "IP CIDR for network."
  default     = ["10.0.0.0/16",]
}

variable "subnets" {
  type = list(object({
    name = string
    ip_cidr = string
  }))
  description = "Name and CIDR for subnet creating."
  default = [ 
    {
    name = "subnet1-pub"
    ip_cidr = "10.0.1.0/24"
    }
  ] 
}