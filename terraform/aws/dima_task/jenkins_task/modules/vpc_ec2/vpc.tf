resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = merge(
    var.tags_vpc,
    var.default_tag,
    {
      Name = "${var.prefix}-vpc"
    },
  )
}
