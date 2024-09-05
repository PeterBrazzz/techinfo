module "s3" {
  source = "./modules/s3"
  prefix = var.prefix
  # tags_bucket = {}
}

module "iam_role" {
  source     = "./modules/iam_role"
  prefix     = var.prefix
  bucket_arn = module.s3.bucket_arn

  # tags_iam_role = {}
  # tags_policy = {}
  # tags_instance_profile = {}
}

module "paris_vpc" {
  source = "./modules/vpc_ec2"
  providers = {
    aws = aws.eu_paris
  }
  prefix             = var.prefix_eu
  profile_name       = module.iam_role.profile_name
  vpc_cidr           = var.eu_vpc_cidr
  privat_subnet_cidr = var.eu_privat_subnet_cidr
  public_subnet_cidr = var.eu_public_subnet_cidr
  instance_type      = var.eu_instance_type
  instance_ami       = var.eu_instance_ami

  # tags_vpc    = {}
  # tags_subnet = {}
  # tags_instance = {}
}

module "tokyo_vpc" {
  source = "./modules/vpc_ec2"
  providers = {
    aws = aws.ap_tokyo
  }
  prefix             = var.prefix_ap
  profile_name       = module.iam_role.profile_name
  vpc_cidr           = var.ap_vpc_cidr
  privat_subnet_cidr = var.ap_privat_subnet_cidr
  public_subnet_cidr = var.ap_public_subnet_cidr
  instance_type      = var.ap_instance_type
  instance_ami       = var.ap_instance_ami

  # tags_vpc    = {}
  # tags_subnet = {}
  # tags_instance = {}
}

module "tokyo_inet_access" {
  source = "./modules/inet_access"
  providers = {
    aws = aws.ap_tokyo
  }
  prefix                 = var.prefix_ap
  vpc_id                 = module.tokyo_vpc.vpc_id
  public_subnet_id       = module.tokyo_vpc.public_subnet_id
  privat_subnet_id       = module.tokyo_vpc.privat_subnet_id
  destination_cidr_block = var.eu_privat_subnet_cidr
  peer_id                = module.peering_tokyo_to_paris.peering_id

}

module "paris_inet_access" {
  source = "./modules/inet_access"
  providers = {
    aws = aws.eu_paris
  }
  prefix                 = var.prefix_eu
  vpc_id                 = module.paris_vpc.vpc_id
  public_subnet_id       = module.paris_vpc.public_subnet_id
  privat_subnet_id       = module.paris_vpc.privat_subnet_id
  destination_cidr_block = var.ap_privat_subnet_cidr
  peer_id                = module.peering_tokyo_to_paris.peering_id
}

module "peering_tokyo_to_paris" {
  source = "./modules/peering"
  providers = {
    aws      = aws.ap_tokyo
    aws.peer = aws.eu_paris
  }
  prefix = var.prefix
  # tags_peer    = {}
  # tags_peer_accepter    = {}
  peer_vpc_id = module.paris_vpc.vpc_id
  vpc_id      = module.tokyo_vpc.vpc_id
}

# module "oregon_vpc" {
#   source = "./modules/vpc_ec2"
#   providers = {
#     aws = aws.us_oregon
#   } 
#   prefix        = var.prefix_us
#   profile_name  = module.iam_role.profile_name
#   vpc_cidr      = var.us_vpc_cidr
#   privat_subnet_cidr   = var.us_privat_subnet_cidr
#   public_subnet_cidr = var.us_public_subnet_cidr
#   instance_type = var.us_instance_type
#   instance_ami  = var.us_instance_ami

#   # tags_vpc    = {}
#   # tags_subnet = {}
#   # tags_instance = {}
# }

# module "oregon_inet_access" {
#   source = "./modules/inet_access"

#     providers = {
#     aws = aws.us_oregon
#   }

#   prefix = var.prefix_us
#   vpc_id = module.oregon_vpc.vpc_id
#   public_subnet_id = module.oregon_vpc.public_subnet_id
#   privat_subnet_id = module.oregon_vpc.privat_subnet_id
#     destination_cidr_block = var.us_privat_subnet_cidr
#     peer_id = module.peering_oregon_to_paris.peering_id
# }


# module "peering_oregon_to_paris" {
#     source = "./modules/peering"

#   providers = {
#     aws = aws.us_oregon
#     aws.peer = aws.eu_paris
#   }
#   prefix        = var.prefix
#   # tags_peer    = {}
#   # tags_peer_accepter    = {}
#   peer_vpc_id = module.paris_vpc.vpc_id
#   vpc_id = module.oregon_vpc.vpc_id
# }
