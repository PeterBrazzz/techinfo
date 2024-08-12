module "network" {
    source = "./modules/network"

    prefix = var.prefix
    rg_name = azurerm_resource_group.this.name
    rg_location = var.location

    network_cidr = var.network_cidr
    subnets = var.subnets
}
