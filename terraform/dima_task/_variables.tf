variable "prefix" {
  description = "Project prefix for naming and tags."
  type        = string
  default     = "p.brazovsky-terraform"
}

##########
# London #
##########

variable "london_vpc_cidr" {
  description = "CIDR block for VPC."
  type        = string
  default     = "10.20.30.0/24"
}

variable "london_privat_subnet_cidr" {
  description = "CIDR block for privat VPC subnet."
  type        = string
  default     = "10.20.30.0/28"
}

# variable "london_public_subnet_cidr" {
#   description = "CIDR block for public VPC subnet"
#   type        = string
#   default     = "10.20.30.16/28"
# }

#########
# Paris #
#########

variable "paris_vpc_cidr" {
  description = "CIDR block for VPC."
  type        = string
  default     = "10.20.32.0/24"
}

variable "paris_privat_subnet_cidr" {
  description = "CIDR block for privat VPC subnet."
  type        = string
  default     = "10.20.32.0/28"
}

# variable "paris_public_subnet_cidr" {
#   description = "CIDR block for public VPC subnet"
#   type        = string
#   default     = "10.20.32.16/28"
# }

#########
# Tags #
#########


variable "default_tag" {
  default     = {
  Owner = "p.brazovsky"
  }
  description = "Additional tag for all resources."
  type        = map(string)
}