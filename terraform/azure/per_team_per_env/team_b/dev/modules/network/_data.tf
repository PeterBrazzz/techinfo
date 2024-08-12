# data "azurerm_subnet" "this" {
#   name                 = var.subnets[0].name
#   virtual_network_name = "${var.prefix}-network"
#   resource_group_name  = var.rg_name
# }