resource "azurerm_subnet" "web_subnet" {
  name                 = "${var.vnet_name}-${var.web_subnet_name}" # "${azurerm_virtual_network.vnet.name}-${var.web_subnet_name}"
  resource_group_name  = var.rg_name                               # azurerm_resource_group.example.name
  virtual_network_name = var.vnet_name                             # azurerm_virtual_network.example.name
  address_prefixes     = var.web_subnet_address
}