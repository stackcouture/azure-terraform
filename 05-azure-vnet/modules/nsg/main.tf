resource "azurerm_network_security_group" "web_subnet_nsg" {
  name                = "${var.web_subnet_name}-nsg " # acceptanceTestSecurityGroup1"
  location            = var.rg_location               # azurerm_resource_group.example.location
  resource_group_name = var.rg_group_name             # azurerm_resource_group.example.name
}

resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_association" {
  subnet_id                 = var.subnet_id # azurerm_subnet.example.id
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id
}