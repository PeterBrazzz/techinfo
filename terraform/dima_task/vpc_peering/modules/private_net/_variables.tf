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

variable "peer_id" {
  description = "Peering connection id"
  type        = string
}

variable "destination_cidr_block" {
  description = "CIDR of the destination subnet"
  type        = string
}
