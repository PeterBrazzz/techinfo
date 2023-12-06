variable "prefix" {
  description = "Project prefix for naming and tags."
  type        = string
  default     = "p.brazovsky-terraform"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC."
  type        = string
  default     = "10.20.30.0/24"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public VPC subnet"
  type        = string
  default     = "10.20.30.0/28"
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