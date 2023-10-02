resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = merge(
    var.tags_vpc,
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
    {
      Name = "${var.prefix}-priv-subnet"
    },
  )
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.public_subnet_cidr

  tags = merge(
    var.tags_subnet,
    {
      Name = "${var.prefix}-pub-subnet"
    },
  )
}

resource "aws_instance" "this" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.privat.id
  vpc_security_group_ids = [aws_security_group.this.id]
  iam_instance_profile   = var.profile_name
  tags = merge(
    var.tags_instance,
    {
      Name = "${var.prefix}-instance"
    },
  )
}
