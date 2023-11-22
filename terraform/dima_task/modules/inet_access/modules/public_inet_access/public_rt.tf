resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = var.public_subnet_id
  route_table_id = aws_route_table.public.id
}

# resource "aws_route_table" "private_nat" {
#   vpc_id = var.vpc_id
#   route {
#     cidr_block     = "0.0.0.0/0"

#   }
# }

# resource "aws_route_table_association" "private_nat" {
#   subnet_id      = var.privat_subnet_id
#   route_table_id = aws_route_table.private_nat.id
# }

resource "aws_route" "private_nat" {
  route_table_id            = var.privat_routetable_id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.this.id
}