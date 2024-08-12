resource "azurerm_storage_account" "this" {
  name                     = "${local.strg_prefix}0storacc"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "this" {
  name                  = "${local.strg_prefix}0content"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}