

resource "azurerm_resource_group" "myProj" {
  name      = var.rg_name
  location  = var.rg_location
}

# Create virtual network
resource "azurerm_virtual_network" "my_vnet" {
  name                = "myVnet"
  address_space       = [ var.DifIps ]
  location            = azurerm_resource_group.myProj.location
  resource_group_name = azurerm_resource_group.myProj.name
}

# Create subnet Public
resource "azurerm_subnet" "External" {
  name                 = "External"
  resource_group_name  = azurerm_resource_group.myProj.name
  virtual_network_name = azurerm_virtual_network.my_vnet.name
  address_prefixes     = [ var.SubnetRange ]
}

/*
# Create public IPs
resource "azurerm_public_ip" "myProjIP" {
  name                = "LB_PublicIP"
  allocation_method   = "Static"
  sku                 = "Standard"
  location            = azurerm_resource_group.myProj.location
  resource_group_name = azurerm_resource_group.myProj.name
}
*/

# Create Network Security Group and rule
resource "azurerm_network_security_group" "myProj" {
  name                = var.NSGname
  location            = azurerm_resource_group.myProj.location
  resource_group_name = azurerm_resource_group.myProj.name

  security_rule {
    name                       = "SSH"
    priority                   = 310
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.SSH_port
    source_address_prefix      = var.SubnetRange
    destination_address_prefix = "*"
  }

  
  security_rule {
    name                       = "TCP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.Application_port
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  
}

// Create network interface
resource "azurerm_network_interface" "myProj" {
   count               = var.Timesof
   name                = "production_Interfaces${count.index}"
   location            = azurerm_resource_group.myProj.location
   resource_group_name = azurerm_resource_group.myProj.name

   ip_configuration {
     name                          = "LBprod"
     subnet_id                     = azurerm_subnet.External.id
     private_ip_address_allocation = "Dynamic"
   }
}

// Connect the security group to the network interface 
resource "azurerm_subnet_network_security_group_association" "myProj" {
  subnet_id = azurerm_subnet.External.id
  network_security_group_id =  azurerm_network_security_group.myProj.id
}
