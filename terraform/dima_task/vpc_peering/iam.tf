module "iam_role" {
  source = "./modules/iam_role"
  prefix = var.prefix
}