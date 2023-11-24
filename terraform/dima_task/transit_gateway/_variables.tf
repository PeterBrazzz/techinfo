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

variable "london_public_subnet_cidr" {
  description = "CIDR block for public VPC subnet"
  type        = string
  default     = "10.20.30.16/28"
}

variable "london_privat_subnet_cidr" {
  description = "CIDR block for privat VPC subnet."
  type        = string
  default     = "10.20.30.0/28"
}


##########
# Irland #
##########

variable "irland_vpc_cidr" {
  description = "CIDR block for VPC."
  type        = string
  default     = "10.20.32.0/24"
}

variable "irland_privat_subnet_cidr" {
  description = "CIDR block for privat VPC subnet."
  type        = string
  default     = "10.20.32.0/28"
}

#############
# Stockholm #
#############

variable "stockholm_vpc_cidr" {
  description = "CIDR block for VPC."
  type        = string
  default     = "10.20.31.0/24"
}

variable "stockholm_privat_subnet_cidr" {
  description = "CIDR block for privat VPC subnet."
  type        = string
  default     = "10.20.31.0/28"
}

#########
# Tags #
#########


variable "default_tag" {
  default = {
    Owner = "p.brazovsky"
  }
  description = "Additional tag for all resources."
  type        = map(string)
}