variable "prefix" {
  description = "Name of the security group"
  type        = string
}

variable "tags_peer" {
  default     = {}
  description = "Additional resource tag for VPC peering"
  type        = map(string)
}

variable "tags_peer_accepter" {
  default     = {}
  description = "Additional resource tag for VPC peering"
  type        = map(string)
}

variable "peer_vpc_id" {
  description = "The ID of the VPC with which you are creating the VPC Peering Connection."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the requester VPC."
  type        = string
}
