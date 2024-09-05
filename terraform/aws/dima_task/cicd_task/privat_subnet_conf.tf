
resource "aws_subnet" "privat" {
  vpc_id     = data.aws_vpc.this.id
  cidr_block = "172.31.48.0/20"
}

data "aws_route_table" "privat_route" {
  subnet_id = aws_subnet.privat.id
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = data.aws_vpc.this.id
  service_name = "com.amazonaws.${data.aws_region.this.name}.s3"
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = "subnet-27967a5e"
}

resource "aws_route_table" "private" {
  vpc_id = data.aws_vpc.this.id

  route {
    cidr_block                = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.privat.id
  route_table_id = aws_route_table.private.id
}