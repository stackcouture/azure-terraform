resource "azurerm_network_security_group" "web_subnet_nsg" {
  name                = "${var.web_subnet_name}-nsg" # acceptanceTestSecurityGroup1"
  location            = var.rg_location              # azurerm_resource_group.example.location
  resource_group_name = var.rg_group_name            # azurerm_resource_group.example.name
}

resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_association" {
  depends_on                = [azurerm_network_security_rule.web_nsg_rule_inbound]
  subnet_id                 = var.subnet_id # azurerm_subnet.example.id
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id
}

resource "azurerm_network_security_rule" "web_nsg_rule_inbound" {
  for_each                    = local.web_inbound_ports_map
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_group_name
  network_security_group_name = "${var.web_subnet_name}-nsg"
}