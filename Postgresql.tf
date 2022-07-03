


#Create Postgresql subnet
resource "azurerm_subnet" "DBsub" {
  name                 = var.DBsubName
  resource_group_name  = azurerm_resource_group.myProj.name
  virtual_network_name = azurerm_virtual_network.my_vnet.name
  address_prefixes     = [var.SubnetRangeDB]
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "myDBProj" {
  name                = "${var.NSGname}-DB_NSG"
  location            = azurerm_resource_group.myProj.location
  resource_group_name = azurerm_resource_group.myProj.name

  security_rule {
    name                       = "SSH-DB"
    priority                   = 310
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 22
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "postgres"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 5432
    source_address_prefix      = var.SubnetRange
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

// Connect the security group to the network interface 
resource "azurerm_subnet_network_security_group_association" "myDBProj" {
  subnet_id = azurerm_subnet.DBsub.id
  network_security_group_id =  azurerm_network_security_group.myDBProj.id
}

# Create private dns zone
resource "azurerm_private_dns_zone" "myProj" {
  name                = "proj.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.myProj.name
}

# Create Network Security Group and rule
resource "azurerm_private_dns_zone_virtual_network_link" "myProj" {
  name                  = "VnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.myProj.name
  virtual_network_id    = azurerm_virtual_network.my_vnet.id
  resource_group_name   = azurerm_resource_group.myProj.name
}

resource "azurerm_postgresql_flexible_server" "myPostgres" {
  name                   = "${var.DBName}-week07"
  resource_group_name    = azurerm_resource_group.myProj.name
  location               = azurerm_resource_group.myProj.location
  version                = "13"
  delegated_subnet_id    = azurerm_subnet.DBsub.id
  private_dns_zone_id    = azurerm_private_dns_zone.myProj.id
  administrator_login    = var.user_information.name
  administrator_password = var.user_information.password
  storage_mb = 32768

  sku_name   = "GP_Standard_D4s_v3"
  depends_on = [azurerm_private_dns_zone_virtual_network_link.myProj]

}

 # change require_secure_transport to false
resource "azurerm_postgresql_flexible_server_configuration" "myPostgres" {
  name      = "require_secure_transport"
  server_id = azurerm_postgresql_flexible_server.myPostgres.id
  value     = "off"
}

