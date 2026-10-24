# Web Subnet
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

# DB Subnet
resource "azurerm_subnet" "db_subnet" {
  name                 = "${var.vnet_name}-${var.db_subnet_name}"
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.db_subnet_address
}

# Bastion / Management Subnet
resource "azurerm_subnet" "bastion_subnet" {
  name                 = "${var.vnet_name}-${var.bastion_subnet_name}"
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.bastion_subnet_address
}

# Bastion Service Subnet
resource "azurerm_subnet" "bastion_service_subnet" {
  name                 = var.bastion_service_subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.virutal_network_name # azurerm_virtual_network.vnet.name
  address_prefixes     = var.bastion_service_address_prefixes
}