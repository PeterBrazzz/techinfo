variable "prefix" {
  description = "The ID of the requester VPC."
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

variable "transit_gateway_id" {
  description = "Transit gateway id"
  type        = string
}

variable "destination_cidr_block" {
  description = "CIDR of the destination subnet"
  type        = list(string)
}
