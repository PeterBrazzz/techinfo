module "public_inet_access" {
    source = "./modules/public_inet_access/"
    count = local.pub_inet_access ? 1 : 0
    prefix = var.prefix
    vpc_id = var.vpc_id
    public_subnet_id = var.public_subnet_id
    privat_subnet_id = var.privat_subnet_id
    privat_routetable_id = aws_route_table.private.id
    depends_on                = [aws_route_table.private]
}