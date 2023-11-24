
resource "aws_ec2_transit_gateway" "this" {
#   description                     = coalesce(var.description, var.name)
  amazon_side_asn                 = random_integer.priority.result
#   default_route_table_association = var.enable_default_route_table_association ? "enable" : "disable"
#   default_route_table_propagation = var.enable_default_route_table_propagation ? "enable" : "disable"
#   auto_accept_shared_attachments  = var.enable_auto_accept_shared_attachments ? "enable" : "disable"
# #   multicast_support               = var.enable_multicast_support ? "enable" : "disable"
#   vpn_ecmp_support                = var.enable_vpn_ecmp_support ? "enable" : "disable"
#   dns_support                     = var.enable_dns_support ? "enable" : "disable"
#   transit_gateway_cidr_blocks     = var.transit_gateway_cidr_blocks

#   timeouts {
#     create = try(var.timeouts.create, null)
#     update = try(var.timeouts.update, null)
#     delete = try(var.timeouts.delete, null)
#   }

#   tags = merge(
#     var.tags,
#     { Name = var.name },
#     var.tgw_tags,
#   )
}


resource "random_integer" "priority" {
  min = 64512
  max = 65534
#   keepers = {
#     # Generate a new integer each time we switch to a new listener ARN
#     listener_arn = var.listener_arn
#   }
}
