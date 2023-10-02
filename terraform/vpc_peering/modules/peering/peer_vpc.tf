resource "aws_vpc_peering_connection" "this" {
  peer_vpc_id = var.peer_vpc_id
  vpc_id      = var.vpc_id
  auto_accept = false
  peer_region = data.aws_region.peer.name

  tags = merge(
    var.tags_peer,
    {
      Name = "${var.prefix}-paris-peering"
    },
  )
}

resource "aws_vpc_peering_connection_accepter" "this" {
  provider                  = aws.peer
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
  auto_accept               = true

  tags = merge(
    var.tags_peer_accepter,
    {
      Side = "Accepter"
    },
  )

}
