resource "aws_ec2_transit_gateway_peering_attachment" "this" {
#   peer_account_id         = aws_ec2_transit_gateway.peer.owner_id
  peer_region             = data.aws_region.peer.name
  peer_transit_gateway_id = var.peer_transit_gateway_id
  transit_gateway_id      = var.local_transit_gateway_id

  tags = {
    Name = "TGW Peering Requestor"
  }
}

resource "aws_ec2_transit_gateway_peering_attachment_accepter" "this" {
  provider = aws.peer
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.this.id

  tags = {
    Name = "Cross-region TGW attachment"
  }
}