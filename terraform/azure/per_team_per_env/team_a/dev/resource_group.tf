resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-resources"
  location = "West Europe"
}