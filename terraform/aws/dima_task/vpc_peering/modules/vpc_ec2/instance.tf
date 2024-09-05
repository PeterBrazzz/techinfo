resource "aws_instance" "this" {
  ami                    = data.aws_ami.this.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.privat.id
  vpc_security_group_ids = [aws_security_group.this.id]
  iam_instance_profile   = var.profile_name
  tags = merge(
    var.tags_instance,
    var.default_tag,
    {
      Name = "${var.prefix}-instance"
    },
  )
}
