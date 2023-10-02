data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = ["MyVPCtag"]
  }
  
}

resource "aws_security_group" "sg" {
   vpc_id = local.vpc_id
   name = var.security_name

   ingress {
     from_port   = "8080"
     to_port     = "8080"
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }
 }
 
resource "aws_instance" "test_instance" {
  ami = var.instance_ami
  instance_type = var.instance_type
  subnet_id = local.subnet_id
  vpc_security_group_ids = [ aws_security_group.sg.id ]
  iam_instance_profile = var.iam_instance_profile
    tags = {
        Name = var.instance_name
        }

}


