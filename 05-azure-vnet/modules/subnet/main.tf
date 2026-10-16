resource "azurerm_subnet" "web_subnet" {
  name                 = "${var.vnet_name}-${var.web_subnet_name}"
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.web_subnet_address
}

# AppTier Subnet
resource "azurerm_subnet" "app_subnet" {
  name                 = "${var.vnet_name}-${var.app_subnet_name}"
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.app_subnet_address
}
