resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    cidr_block                = var.destination_cidr_block
    vpc_peering_connection_id = var.peer_id
  }

  # route {
  #   cidr_block     = "0.0.0.0/0"
  #   nat_gateway_id = aws_nat_gateway.this.id
  # }

}

resource "aws_route_table_association" "private" {
  subnet_id      = var.privat_subnet_id
  route_table_id = aws_route_table.private.id
}
