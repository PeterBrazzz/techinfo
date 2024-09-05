resource "aws_security_group" "ecs_service" {
  name   = local.sg_service
  vpc_id = var.vpc_id
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
