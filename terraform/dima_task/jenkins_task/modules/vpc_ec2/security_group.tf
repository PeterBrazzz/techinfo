resource "aws_security_group" "this" {
  vpc_id = aws_vpc.this.id
  name   = "${var.prefix}-security_group"

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags_security_group,
    var.default_tag,
    {
      Name = "${var.prefix}-priv-subnet"
    },
  )
}
