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

resource "aws_subnet" "privat" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.privat_subnet_cidr

  tags = merge(
    var.tags_subnet,
    var.default_tag,
    {
      Name = "${var.prefix}-priv-subnet"
    },
  )
}

resource "aws_subnet" "public" {
  count = local.create_pub_subnet ? 1 : 0
  vpc_id     = aws_vpc.this.id
  cidr_block = var.public_subnet_cidr

  tags = merge(
    var.tags_subnet,
    var.default_tag,
    {
      Name = "${var.prefix}-pub-subnet"
    },
  )
}
