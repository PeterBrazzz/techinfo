##########
# London #
##########

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
  
  destination_cidr_block = [
    var.irland_privat_subnet_cidr,
    var.stockholm_privat_subnet_cidr,
  ] 
  transit_gateway_id                = module.london_transit_gtw.id
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

module "london_transit_gtw" {
  source = "./modules/transit_gtw/tgw_creation"
  providers = {
    aws = aws.eu_london
  }
  prefix               = "${var.prefix}-tgw-london"
  vpc_id               = module.vpc_london.vpc_id
  privat_subnet_id     = module.vpc_london.privat_subnet_id
  
  default_tag        = var.default_tag
}

##########
# Irland #
##########

module "vpc_irland" {
  source = "./modules/vpc_ec2"
  providers = {
    aws = aws.eu_irland
  }
  prefix             = "${var.prefix}-irland"
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

  destination_cidr_block = [
    var.london_privat_subnet_cidr,
    var.stockholm_privat_subnet_cidr,
  ] 
  transit_gateway_id                = module.irland_transit_gtw.id
}

module "irland_transit_gtw" {
  source = "./modules/transit_gtw/tgw_creation"
  providers = {
    aws = aws.eu_irland
  }
  prefix               = "${var.prefix}-tgw-irland"
  vpc_id               = module.vpc_irland.vpc_id
  privat_subnet_id     = module.vpc_irland.privat_subnet_id
  
  default_tag        = var.default_tag
}

#############
# Stockholm #
#############

module "vpc_stockholm" {
  source = "./modules/vpc_ec2"
  providers = {
    aws = aws.eu_stockholm
  }
  prefix             = "${var.prefix}-stockholm"
  vpc_cidr           = var.stockholm_vpc_cidr
  privat_subnet_cidr = var.stockholm_privat_subnet_cidr
  default_tag        = var.default_tag
}

module "stockholm_private_route" {
  source = "./modules/private_net"
  providers = {
    aws = aws.eu_stockholm
  }
  prefix                 = "${var.prefix}-stockholm"
  vpc_id                 = module.vpc_stockholm.vpc_id
  privat_subnet_id       = module.vpc_stockholm.privat_subnet_id
  
  destination_cidr_block = [
    var.irland_privat_subnet_cidr,
    var.london_privat_subnet_cidr,
  ]
  transit_gateway_id                = module.stockholm_transit_gtw.id
}

module "stockholm_transit_gtw" {
  source = "./modules/transit_gtw/tgw_creation"
  providers = {
    aws = aws.eu_stockholm
  }
  prefix               = "${var.prefix}-tgw-stockholm"
  vpc_id               = module.vpc_stockholm.vpc_id
  privat_subnet_id     = module.vpc_stockholm.privat_subnet_id

  default_tag        = var.default_tag
}


##############################
# TGW attachments to regions #
##############################

module "tgw_attachment_london_to_stockholm" {
  source = "./modules/transit_gtw/tgw_attachment"
  providers = {
    aws      = aws.eu_london
    aws.peer = aws.eu_stockholm
  }
  prefix = var.prefix
  local_transit_gateway_id = module.london_transit_gtw.id
  peer_transit_gateway_id = module.stockholm_transit_gtw.id

  tgw_route_table_id = {
    local = module.london_transit_gtw.default_route_table_id
    peer = module.stockholm_transit_gtw.default_route_table_id
  }

  destination_cidr_block = {
    local = var.stockholm_privat_subnet_cidr,
    peer = var.london_privat_subnet_cidr,
  }
}

module "tgw_attachment_stockholm_to_ireland" {
  source = "./modules/transit_gtw/tgw_attachment"
  providers = {
    aws      = aws.eu_stockholm
    aws.peer = aws.eu_irland
  }
  prefix = var.prefix
  local_transit_gateway_id = module.stockholm_transit_gtw.id
  peer_transit_gateway_id = module.irland_transit_gtw.id

  tgw_route_table_id = {
    local = module.stockholm_transit_gtw.default_route_table_id
    peer = module.irland_transit_gtw.default_route_table_id
  }

  destination_cidr_block = {
    local = var.irland_privat_subnet_cidr,
    peer = var.stockholm_privat_subnet_cidr,
  }
}


module "tgw_attachment_irland_to_london" {
  source = "./modules/transit_gtw/tgw_attachment"
  providers = {
    aws      = aws.eu_irland
    aws.peer = aws.eu_london
  }
  prefix = var.prefix
  local_transit_gateway_id = module.irland_transit_gtw.id
  peer_transit_gateway_id = module.london_transit_gtw.id

  tgw_route_table_id = {
    local = module.irland_transit_gtw.default_route_table_id
    peer = module.london_transit_gtw.default_route_table_id
  }

  destination_cidr_block = {
    local = var.london_privat_subnet_cidr,
    peer = var.irland_privat_subnet_cidr,
  }
}
