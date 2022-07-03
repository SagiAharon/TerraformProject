

// create Load Balancer
resource "azurerm_lb" "myProj" {
 name                = var.LBName
 sku                 = "Standard"
 location            = azurerm_resource_group.myProj.location
 resource_group_name = azurerm_resource_group.myProj.name

 frontend_ip_configuration {
   name                 = "LBprod"
   public_ip_address_id = azurerm_public_ip.myProjIP.id
 }
}

# Create public IPs
resource "azurerm_public_ip" "myProjIP" {
  name                = "LB_PublicIP"
  allocation_method   = "Static"
  sku                 = "Standard"
  location            = azurerm_resource_group.myProj.location
  resource_group_name = azurerm_resource_group.myProj.name
}

// create Load Balancer outbound rule
resource "azurerm_lb_outbound_rule" "myProj" {
  loadbalancer_id         = azurerm_lb.myProj.id
  name                    = "OutRule"
  protocol                = "Tcp"
  backend_address_pool_id = azurerm_lb_backend_address_pool.myProj.id

  frontend_ip_configuration {
    name = "LBprod"
  }
}

// create Load Balancer pool
resource "azurerm_lb_backend_address_pool" "myProj" {
 loadbalancer_id     = azurerm_lb.myProj.id
 name                = "BackPool"
}

// create Load Balancer Probe
resource "azurerm_lb_probe" "myProj" {
 loadbalancer_id     = azurerm_lb.myProj.id
 name                = "TCP"
 port                = var.Application_port
}

// create Load Balancer rule
resource "azurerm_lb_rule" "myProj" {
   loadbalancer_id                = azurerm_lb.myProj.id
   name                           = "LBprodRule"
   protocol                       = "Tcp"
   frontend_port                  = var.Application_port
   backend_port                   = var.Application_port
   frontend_ip_configuration_name = "LBprod"
   probe_id                       = azurerm_lb_probe.myProj.id
   backend_address_pool_ids = [ azurerm_lb_backend_address_pool.myProj.id ]
   disable_outbound_snat          = true
}