locals {
  create_pub_subnet = var.public_subnet_cidr != null ? true : false
}