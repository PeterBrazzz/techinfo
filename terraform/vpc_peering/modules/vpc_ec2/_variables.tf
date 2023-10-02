variable "tags_vpc" {
  default     = {}
  description = "Additional resource tag for VPC"
  type        = map(string)
}

variable "tags_subnet" {
  default     = {}
  description = "Additional resource tag for subnet"
  type        = map(string)
}

variable "tags_instance" {
  default     = {}
  description = "Additional resource tag for instance"
  type        = map(string)
}

variable "prefix" {
  description = "Name of the security group"
  type        = string
}

variable "privat_subnet_cidr" {
  description = "CIDR for privat subnet"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "instance_type" {
  description = "Type of the EC2 instance"
  type        = string
}

variable "instance_ami" {
  description = "AMI of the EC2 instance"
  type        = string
}

variable "profile_name" {
  description = "Name of the profile for attaching role to instance"
  type        = string
}
