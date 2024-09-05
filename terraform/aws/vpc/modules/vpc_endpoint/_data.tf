data "aws_region" "current" {}

data "aws_vpc" "this" {
  id = var.vpc_id
}
