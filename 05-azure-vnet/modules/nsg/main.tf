# Web Subnet Network Security Group
resource "azurerm_network_security_group" "web_subnet_nsg" {
  name                = "${var.web_subnet_name}-nsg"
  location            = var.rg_location
  resource_group_name = var.rg_group_name
}

resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_association" {
  depends_on                = [azurerm_network_security_rule.web_nsg_rule_inbound]
  subnet_id                 = var.subnet_id
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
  network_security_group_name = azurerm_network_security_group.web_subnet_nsg.name # "${var.web_subnet_name}-nsg"
}


# App Subnet Network Security Group
resource "azurerm_network_security_group" "app_subnet_nsg" {
  name                = "${var.app_subnet_name}-nsg"
  location            = var.rg_location
  resource_group_name = var.rg_group_name
}

resource "azurerm_subnet_network_security_group_association" "app_subnet_nsg_association" {
  depends_on                = [azurerm_network_security_rule.app_nsg_rule_inbound]
  subnet_id                 = var.app_subnet_id
  network_security_group_id = azurerm_network_security_group.app_subnet_nsg.id
}

resource "azurerm_network_security_rule" "app_nsg_rule_inbound" {
  for_each                    = local.app_inbound_ports_map
  name                        = "App-Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_group_name
  network_security_group_name = azurerm_network_security_group.app_subnet_nsg.name #  "${var.app_subnet_name}-nsg"
}