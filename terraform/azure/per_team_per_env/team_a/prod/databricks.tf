resource "azurerm_databricks_workspace" "example" {
  name                = "databricks-${var.prefix}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "standard"

  tags = {
    Team = "${var.team}"
    Environment = "Production"
  }
}