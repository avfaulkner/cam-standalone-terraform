# Create a resource group for all resources
resource "azurerm_resource_group" "cam-resgrp" {
  name     = "cam-resources"
  location = "eastus"

  tags = {
    Name = "cam-resources"
  }
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "cam-network" {
  name                = "example-network"
  resource_group_name = azurerm_resource_group.cam-resgrp.name
  location            = azurerm_resource_group.cam-resgrp.location
  address_space       = ["10.0.0.0/16"]
}

# Route tables
# Public


# Subnets
# Public
resource "azurerm_subnet" "subnet-public" {
  name                 = "cam-subnet-pub"
  resource_group_name  = azurerm_resource_group.cam-resgrp.name
  virtual_network_name = azurerm_virtual_network.cam-network.name
  address_prefixes       = ["10.0.10.0/24"]
}

resource "azurerm_public_ip" "cam-ip" {
  location = "eastus"
  name = "cam-ip"
  resource_group_name = azurerm_resource_group.cam-resgrp.name
  allocation_method = "Dynamic"
}

resource "azurerm_network_interface" "cam-nic" {
  name                        = "cam-nic"
  location                    = "eastus"
  resource_group_name         = azurerm_resource_group.cam-resgrp.name

  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = azurerm_subnet.subnet-public.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.cam-ip.id
  }

  tags = {
    Name = "cam-nic"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "sg-nic" {
  network_interface_id      = azurerm_network_interface.cam-nic.id
  network_security_group_id = azurerm_network_security_group.cam-sg.id
}

# Storage account. The storage account is only to store the boot diagnostics data
resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.cam-resgrp.name
  }

  byte_length = 8
}

resource "azurerm_storage_account" "mystorageaccount" {
  name                        = "diag${random_id.randomId.hex}"
  resource_group_name         = azurerm_resource_group.cam-resgrp.name
  location                    = "eastus"
  account_replication_type    = "LRS"
  account_tier                = "Standard"

  tags = {
    Name = "cam-storage-account"
  }
}