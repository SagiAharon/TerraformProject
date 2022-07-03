
# Create WebServer virtual machines 
 resource "azurerm_linux_virtual_machine" "myProj" {
  count                 = var.Timesof
  name                  = "WebApp${count.index}"
  location              = azurerm_resource_group.myProj.location
  resource_group_name   = azurerm_resource_group.myProj.name
  network_interface_ids = [element(azurerm_network_interface.myProj.*.id, count.index)]
  size                  = var.Size

  os_disk {
    name                 = "myOsDisk${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name  = "VMsNO-${count.index}"
  admin_username = var.user_information.name
  admin_password = var.user_information.password
  disable_password_authentication = false
 }


 # Connect the VMs to my load balancer 
resource "azurerm_network_interface_backend_address_pool_association" "myProj" {
  count = var.Timesof
  network_interface_id    = element(azurerm_network_interface.myProj.*.id, count.index)
  ip_configuration_name   = "LBprod"
  backend_address_pool_id = azurerm_lb_backend_address_pool.myProj.id
}