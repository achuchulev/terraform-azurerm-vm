resource "azurerm_resource_group" "main" {
  name     = "test-resources"
  location = "West US 2"
}

resource "azurerm_virtual_network" "main" {
  name                = "test-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "test" {
  name                = "test-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "test" {
  name                  = "tf-cloud-example"
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  network_interface_ids = [azurerm_network_interface.test.id]
  vm_size               = "Standard_D2a_v4"

  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "T3st@dmin"
  }

  storage_os_disk {
    name              = "tf-disk"
    create_option     = "FromImage"
    caching           = "ReadWrite"
    #managed_disk_type = "Premium_LRS"
    #managed_disk_type = "Standard_LRS"
    managed_disk_type = "StandardSSD_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
