variable "prefix" {
  description = "Name of the security group."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the requester VPC."
  type        = string
}

variable "privat_subnet_id" {
  description = "The ID of the requester VPC."
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

