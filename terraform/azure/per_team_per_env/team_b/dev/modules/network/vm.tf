resource "azurerm_network_interface" "this" {
  name                = "${var.prefix}-nic"
  location            = "uksouth"
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "configuration1"
    subnet_id                     = azurerm_subnet.this["subnet1-pub"].id 
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "this" {
  name                  = "${var.prefix}-vm"
  location              = "uksouth"
  resource_group_name   = var.rg_name
  network_interface_ids = [azurerm_network_interface.this.id]
  vm_size               = "Standard_B1s"

  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${var.prefix}-public-vm"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "${var.prefix}"
  }
}