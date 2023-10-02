locals {
  vpc_id = data.aws_subnet.selected.vpc_id
  subnet_id = data.aws_subnet.selected.id
}