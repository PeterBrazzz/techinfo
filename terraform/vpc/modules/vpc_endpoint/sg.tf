resource "aws_security_group" "this" {
  name        = local.sg_name
  vpc_id      = var.vpc_id
  description = "SG for PrivateLink endpoint"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.this.cidr_block]
  }

  tags = local.sg_tags
}
