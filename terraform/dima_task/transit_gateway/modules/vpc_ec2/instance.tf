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

# aws ec2 describe-images --filters Name=name,Values=al2023-ami-2023.2.20231113.0-kernel-6.1-x86_64
# aws ec2 describe-images --image-ids=ami-0416c18e75bd69567
