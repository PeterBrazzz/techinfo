resource "azurerm_virtual_network" "this" {
  name                = "${var.prefix}-network"
  location            = "uksouth" # var.rg_location
  resource_group_name = var.rg_name
  address_space       = var.network_cidr
}

resource "azurerm_subnet" "this" {
  for_each = { for sbnt in var.subnets : sbnt.name => sbnt }
  
  name                 = each.value.name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [each.value.ip_cidr]
}
