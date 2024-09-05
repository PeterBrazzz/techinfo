provider "aws" {
  region = "us-east-2"
}

module "iam_role" {
  source = "./module/iam-role/"

  role_name = "my_role"
  policy_name = "my_policy"
  profile_name = "my_profile"
}

module "instance_sg" {
  source = "./module/instance-sg/"
  
  iam_instance_profile = module.iam_role.profile_name
  security_name = "abobus"
  instance_ami = "ami-0568773882d492fc8"
  instance_name = "Chiiips"
  instance_type = "t2.micro"
  
}

