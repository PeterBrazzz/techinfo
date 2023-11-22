variable "prefix" {
  description = "Name of the security group."
  type        = string
}

variable "privat_subnet_cidr" {
  description = "CIDR for privat subnet."
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  type        = string
  default = null
}

variable "vpc_cidr" {
  description = "CIDR block for VPC."
  type        = string
}

variable "instance_type" {
  description = "Type of the EC2 instance."
  type        = string
  default = "t2.micro"
}

variable "profile_name" {
  description = "Name of the profile for attaching role to instance."
  type        = string
}

########
# Tags #
########

variable "default_tag" {
  default     = {}
  description = "Additional tag for all resources."
  type        = map(string)
}

variable "tags_vpc" {
  default     = {}
  description = "Additional resource tag for VPC"
  type        = map(string)
}

variable "tags_subnet" {
  default     = {}
  description = "Additional resource tag for subnet."
  type        = map(string)
}


variable "tags_security_group" {
  default     = {}
  description = "Additional resource tag for sg."
  type        = map(string)
}

variable "tags_instance" {
  default     = {}
  description = "Additional resource tag for instance."
  type        = map(string)
}
