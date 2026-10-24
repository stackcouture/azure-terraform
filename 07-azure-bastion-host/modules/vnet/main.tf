# Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.resource_name_prefix}-${var.vnet_name}"
  address_space       = var.vnet_address_space
  location            = var.rg_location
  resource_group_name = var.rg_group_name
  tags                = var.common_tags
}
