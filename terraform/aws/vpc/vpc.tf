resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  tags                 = local.vpc_tags
}

module "vpc_subnet_public" {
  source      = "./modules/vpc_subnet"
  name_prefix = var.name_prefix
  vpc_id      = aws_vpc.this.id
  cidr_suffix = var.vpc_subnet_public_suffix
}

module "vpc_subnet_private" {
  source      = "./modules/vpc_subnet"
  name_prefix = var.name_prefix
  vpc_id      = aws_vpc.this.id
  nat_subnets = [module.vpc_subnet_public.id[0]]
  cidr_suffix = var.vpc_subnet_private_suffix
}

module "vpc_endpoint" {
  for_each     = toset(var.vpc_endpoints)
  source       = "./modules/vpc_endpoint"
  name_prefix  = var.name_prefix
  service_name = each.key
  vpc_id       = aws_vpc.this.id
  subnets      = module.vpc_subnet_private.id
}

module "vpc_flow_logs" {
  source      = "./modules/vpc_flow_logs"
  vpc_id      = aws_vpc.this.id
  name_prefix = var.name_prefix
}
