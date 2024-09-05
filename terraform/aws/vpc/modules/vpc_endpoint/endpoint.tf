resource "aws_vpc_endpoint" "this" {
  service_name        = local.vpc_endpoint_name
  vpc_endpoint_type   = "Interface"
  vpc_id              = var.vpc_id
  subnet_ids          = var.subnets
  private_dns_enabled = var.private_dns_enabled
  security_group_ids  = [aws_security_group.this.id]
  tags                = local.endpoint_tags
}
