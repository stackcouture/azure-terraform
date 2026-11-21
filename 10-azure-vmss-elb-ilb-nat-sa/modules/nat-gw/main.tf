
# Resource-1: Create Public IP for Azure NAT Gateway
resource "azurerm_public_ip" "natgw_publicip" {
  name                = "${var.resource_name_prefix}-natgw-pip"
  location            = var.rg_location
  resource_group_name = var.rg_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Resource-2: Create Azure NAT Gateway
resource "azurerm_nat_gateway" "natgw" {
  name                = "${var.resource_name_prefix}-natgw"
  location            = var.rg_location
  resource_group_name = var.rg_group_name
  sku_name            = "Standard"
}

# Resource-3: Associate Azure NAT Gateway and Public IP
resource "azurerm_nat_gateway_public_ip_association" "natgw_pip_associate" {
  nat_gateway_id       = azurerm_nat_gateway.natgw.id
  public_ip_address_id = azurerm_public_ip.natgw_publicip.id
}

# Resource-4: Associate AppSubnet and Azure NAT Gateway
resource "azurerm_subnet_nat_gateway_association" "natgw_appsubnet_associate" {
  #   subnet_id      = azurerm_subnet.appsubnet.id
  subnet_id      = var.appsubnet_id
  nat_gateway_id = azurerm_nat_gateway.natgw.id
}