resource "azurerm_public_ip" "bastion_service_publicip" {
  name                = "${var.resource_name_prefix}-bastion-service-publicip"
  location            = var.rg_location
  resource_group_name = var.rg_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion_host" {
  name                = "${var.resource_name_prefix}-bastion-service"
  location            = var.rg_location
  resource_group_name = var.rg_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.bastion_service_subnet_id # azurerm_subnet.bastion_service_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_service_publicip.id
  }
}