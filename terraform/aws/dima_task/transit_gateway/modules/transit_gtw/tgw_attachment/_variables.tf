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

variable "peer_transit_gateway_id" {
  description = "The ID of the TGW with which you are creating peering connection."
  type        = string
}

variable "local_transit_gateway_id" {
  description = "The ID of the requester TGW."
  type        = string
}

variable "destination_cidr_block" {
  description = "CIDR of the destination subnet"
  type        = map(string)
}

variable "tgw_route_table_id" {
  description = "TGW id for route teble."
  type        = map(string)
}