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

# DB Subnet Network Security Group
resource "azurerm_network_security_group" "db_subnet_nsg" {
  name                = "${var.db_subnet_name}-nsg"
  location            = var.rg_location
  resource_group_name = var.rg_group_name
}

resource "azurerm_subnet_network_security_group_association" "db_subnet_nsg_association" {
  depends_on                = [azurerm_network_security_rule.db_nsg_rule_inbound]
  subnet_id                 = var.db_subnet_id
  network_security_group_id = azurerm_network_security_group.db_subnet_nsg.id
}

resource "azurerm_network_security_rule" "db_nsg_rule_inbound" {
  for_each                    = local.db_inbound_ports_map
  name                        = "DB-Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_group_name
  network_security_group_name = azurerm_network_security_group.db_subnet_nsg.name #  "${var.app_subnet_name}-nsg"
}

# Bastion Network Security Group (NSG)
resource "azurerm_network_security_group" "bastion_subnet_nsg" {
  name                = "${var.bastion_subnet_name}-nsg"
  location            = var.rg_location
  resource_group_name = var.rg_group_name
}

# Associate Bastion NSG 
resource "azurerm_subnet_network_security_group_association" "bastion_subnet_nsg_associate" {
  depends_on                = [azurerm_network_security_rule.bastion_nsg_rule_inbound]
  subnet_id                 = var.bastion_subnet_id # azurerm_subnet.bastionsubnet.id
  network_security_group_id = azurerm_network_security_group.bastion_subnet_nsg.id
}

# NSG Inbound Rule for Bastion Subnets
resource "azurerm_network_security_rule" "bastion_nsg_rule_inbound" {
  for_each                    = local.bastion_inbound_ports_map
  name                        = "Bastion-Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_group_name
  network_security_group_name = azurerm_network_security_group.bastion_subnet_nsg.name
}


# # NSG for VM
# resource "azurerm_network_security_group" "web_vmnic_nsg" {
#   name                = "${var.web_linuxvm_nic_name}-nsg" # azurerm_network_interface.web_linuxvm_nic.name}-nsg"
#   location            = var.rg_location
#   resource_group_name = var.rg_group_name
# }

# resource "azurerm_network_interface_security_group_association" "web_vmnic_nsg_associate" {
#   depends_on                = [azurerm_network_security_rule.web_vmnic_nsg_rule_inbound]
#   network_interface_id      = var.web_linuxvm_nic_id # azurerm_network_interface.web_linuxvm_nic.id
#   network_security_group_id = azurerm_network_security_group.web_vmnic_nsg.id
# }

# locals {
#   web_vmnic_inbound_ports_map = {
#     "100" : "80", # If the key starts with a number, you must use the colon syntax ":" instead of "="
#     "110" : "443",
#     "120" : "22"
#   }
# }
# ## NSG Inbound Rule for WebTier Subnets
# resource "azurerm_network_security_rule" "web_vmnic_nsg_rule_inbound" {
#   for_each                    = local.web_vmnic_inbound_ports_map
#   name                        = "Rule-Port-${each.value}"
#   priority                    = each.key
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = each.value
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = var.rg_group_name
#   network_security_group_name = azurerm_network_security_group.web_vmnic_nsg.name
# }