# module "vpc" {
#   source = "./modules/vpc_ec2"

#   prefix             = var.prefix
#   profile_name       = module.iam_role.profile_name
#   vpc_cidr           = var.vpc_cidr
#   public_subnet_cidr = var.public_subnet_cidr
#   default_tag        = var.default_tag
# }

module "iam_role" {
  source = "./modules/iam_role"
  prefix = "${var.prefix}-iam-role"
}