resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  dynamic "route" {
    for_each = var.destination_cidr_block
    content {
    cidr_block                = route.value
    transit_gateway_id = var.transit_gateway_id
    }
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = var.privat_subnet_id
  route_table_id = aws_route_table.private.id
}
