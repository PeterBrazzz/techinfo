data "aws_ami" "this" {
  most_recent      = true
  name_regex       = "Windows_Server-2022-English-Full-Base-2023.11.15"
  owners           = ["amazon"]

  # filter {
  #   name   = "name"
  #   values = ["^Microsoft Windows Serve*"]
  # }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}