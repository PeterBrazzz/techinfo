resource "aws_ec2_transit_gateway_route" "local" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.this.id


  destination_cidr_block         = var.destination_cidr_block["local"]
  transit_gateway_route_table_id = var.tgw_route_table_id["local"]

}

resource "aws_ec2_transit_gateway_route" "peer" {
    provider = aws.peer
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.this.id


  destination_cidr_block         = var.destination_cidr_block["peer"]
  transit_gateway_route_table_id = var.tgw_route_table_id["peer"]
}
