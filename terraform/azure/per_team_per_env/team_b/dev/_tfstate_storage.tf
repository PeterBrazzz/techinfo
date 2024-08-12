resource "azurerm_resource_group" "tfstate" {
  name     = "tfstate-${var.team}"
  location = var.location
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstate0${local.strg_team}"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false

  tags = {
    team = "${var.team}"
    environment = "dev and prod"
  }
}

resource "azurerm_storage_container" "tfstate_dev" {
  name                  = "tfstate0${local.strg_prefix}"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "tfstate_prod" {
  name                  = "tfstate0team0b0prod"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}