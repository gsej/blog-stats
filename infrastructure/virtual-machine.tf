# Define a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.service-name}"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.group.name
}

# Define a subnet
resource "azurerm_subnet" "subnet" {
  name                 = "snet-${var.service-name}"
  resource_group_name  = azurerm_resource_group.group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Define a public IP address
resource "azurerm_public_ip" "public_ip" {
  name                = "public-ip-${var.service-name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.group.name
  allocation_method   = "Dynamic"
}

# Define a network interface
resource "azurerm_network_interface" "nic" {
  name                = "nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.group.name

  ip_configuration {
    name                          = "nic-configuration"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

# Define a virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "vm-${var.service-name}"
  location              = var.location
  resource_group_name   = azurerm_resource_group.group.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = "Standard_B1s"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name  = "hostname"
  admin_username = "adminuser"
  admin_password =  var.ADMIN_PASSWORD

  disable_password_authentication = false
}

variable "ADMIN_PASSWORD" {
  description = "The admin password for the VM"
  type        = string
}
