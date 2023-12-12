resource "aws_security_group" "code_build" {
  name   = local.code_build_sg
  vpc_id = var.code_build_vpc_id
  tags   = local.code_build.sg_tags
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
