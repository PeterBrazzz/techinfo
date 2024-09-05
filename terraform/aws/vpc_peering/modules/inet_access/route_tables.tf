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

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    cidr_block                = var.destination_cidr_block
    vpc_peering_connection_id = var.peer_id
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }
}
# aws ec2 describe-images --filters Name=name,Values=al2023-ami-2023.2.20231113.0-kernel-6.1-x86_64
# al2023-ami-2023.2.20231113.0-kernel-6.1-x86_64
# aws ec2 describe-images --filters Name=image-id,Values=ami-07355fe79b493752d

resource "aws_route_table_association" "private" {
  subnet_id      = var.privat_subnet_id
  route_table_id = aws_route_table.private.id
}
