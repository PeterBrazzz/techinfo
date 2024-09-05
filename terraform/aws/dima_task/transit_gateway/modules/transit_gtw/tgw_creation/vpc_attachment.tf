resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  subnet_ids         = [var.privat_subnet_id]
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  vpc_id             = var.vpc_id
}
