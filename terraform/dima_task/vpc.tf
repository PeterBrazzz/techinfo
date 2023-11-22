module "vpc_london" {
  source = "./modules/vpc_ec2"
  providers = {
    aws = aws.eu_london
  }
  prefix             = "${var.prefix}-london"
  profile_name       = module.iam_role.profile_name
  vpc_cidr           = var.london_vpc_cidr
  privat_subnet_cidr = var.london_privat_subnet_cidr
  public_subnet_cidr = var.london_public_subnet_cidr
  default_tag = var.default_tag
}

module "london_inet_access" {
  source = "./modules/inet_access"
  providers = {
    aws = aws.eu_london
  }
  prefix                 = "${var.prefix}-london"
  vpc_id                 = module.vpc_london.vpc_id
  public_subnet_id       = module.vpc_london.public_subnet_id
  privat_subnet_id       = module.vpc_london.privat_subnet_id
  destination_cidr_block = var.paris_privat_subnet_cidr
  peer_id                = module.peering_london_to_paris.peering_id
}

module "vpc_paris" {
  source = "./modules/vpc_ec2"
  providers = {
    aws = aws.eu_paris
  }
  prefix             = "${var.prefix}-paris"
  profile_name       = module.iam_role.profile_name
  vpc_cidr           = var.paris_vpc_cidr
  privat_subnet_cidr = var.paris_privat_subnet_cidr
  default_tag = var.default_tag
}

module "paris_inet_access" {
  source = "./modules/inet_access"
  providers = {
    aws = aws.eu_paris
  }
  prefix                 = "${var.prefix}-paris"
  vpc_id                 = module.vpc_paris.vpc_id
  privat_subnet_id       = module.vpc_paris.privat_subnet_id
  destination_cidr_block = var.london_privat_subnet_cidr
  peer_id                = module.peering_london_to_paris.peering_id
}

module "peering_london_to_paris" {
  source = "./modules/peering"
  providers = {
    aws      = aws.eu_paris
    aws.peer = aws.eu_london
  }
  prefix = var.prefix
  # tags_peer    = {}
  # tags_peer_accepter    = {}
  peer_vpc_id = module.vpc_london.vpc_id
  vpc_id      = module.vpc_paris.vpc_id
}