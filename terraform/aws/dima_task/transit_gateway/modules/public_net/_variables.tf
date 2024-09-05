variable "prefix" {
  description = "The ID of the requester VPC."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the requester VPC."
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  type        = string
  default = null
}

variable "privat_subnet_id" {
  description = "The ID of the requester VPC."
  type        = string
}

variable "privat_routetable_id" {
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

variable "tags_subnet" {
  default     = {}
  description = "Additional resource tag for subnet."
  type        = map(string)
}
