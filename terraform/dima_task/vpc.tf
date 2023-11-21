module "vpc_paris" {
  source = "./modules/vpc_ec2"
  providers = {
    aws = aws.eu_paris
  }
  prefix             = "${var.prefix}-paris"
  profile_name       = module.iam_role.profile_name
  vpc_cidr           = var.paris_vpc_cidr
  privat_subnet_cidr = var.paris_privat_subnet_cidr
  # public_subnet_cidr = var.paris_public_subnet_cidr
  default_tag = var.default_tag
}

module "vpc_london" {
  source = "./modules/vpc_ec2"
  providers = {
    aws = aws.eu_london
  }
  prefix             = "${var.prefix}-london"
  profile_name       = module.iam_role.profile_name
  vpc_cidr           = var.london_vpc_cidr
  privat_subnet_cidr = var.london_privat_subnet_cidr
  # public_subnet_cidr = var.london_public_subnet_cidr
  default_tag = var.default_tag
}
