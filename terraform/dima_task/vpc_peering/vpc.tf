module "vpc_london" {
  source = "./modules/vpc_ec2"
  providers = {
    aws = aws.eu_london
  }
  prefix             = "${var.prefix}-london"
  profile_name       = module.iam_role.profile_name
  vpc_cidr           = var.london_vpc_cidr
  privat_subnet_cidr = var.london_privat_subnet_cidr
  default_tag        = var.default_tag
}

module "london_private_route" {
  source = "./modules/private_net"
  providers = {
    aws = aws.eu_london
  }
  prefix                 = "${var.prefix}-london"
  vpc_id                 = module.vpc_london.vpc_id
  privat_subnet_id       = module.vpc_london.privat_subnet_id
  destination_cidr_block = var.irland_privat_subnet_cidr
  peer_id                = module.peering_london_to_irland.peering_id
}

module "london_public_inet_access" {
  source = "./modules/public_net"
  providers = {
    aws = aws.eu_london
  }
  prefix               = "${var.prefix}-london"
  vpc_id               = module.vpc_london.vpc_id
  public_subnet_cidr   = var.london_public_subnet_cidr
  privat_subnet_id     = module.vpc_london.privat_subnet_id
  privat_routetable_id = module.london_private_route.privat_routetable_id
  default_tag          = var.default_tag
}

module "vpc_irland" {
  source = "./modules/vpc_ec2"
  providers = {
    aws = aws.eu_irland
  }
  prefix             = "${var.prefix}-irland"
  profile_name       = module.iam_role.profile_name
  vpc_cidr           = var.irland_vpc_cidr
  privat_subnet_cidr = var.irland_privat_subnet_cidr
  default_tag        = var.default_tag
}

module "irland_private_route" {
  source = "./modules/private_net"
  providers = {
    aws = aws.eu_irland
  }
  prefix                 = "${var.prefix}-irland"
  vpc_id                 = module.vpc_irland.vpc_id
  privat_subnet_id       = module.vpc_irland.privat_subnet_id
  destination_cidr_block = var.london_privat_subnet_cidr
  peer_id                = module.peering_london_to_irland.peering_id
}

module "peering_london_to_irland" {
  source = "./modules/peering"
  providers = {
    aws      = aws.eu_irland
    aws.peer = aws.eu_london
  }
  prefix = var.prefix
  peer_vpc_id = module.vpc_london.vpc_id
  vpc_id      = module.vpc_irland.vpc_id
}