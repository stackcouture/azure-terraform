# # Resource-1: Create Public IP Address
# resource "azurerm_public_ip" "web_linuxvm_publicip" {
#   name = "${local.resource_name_prefix}-web-linuxvm-publicip"
#   resource_group_name = azurerm_resource_group.rg.name
#   location = azurerm_resource_group.rg.location
#   allocation_method = "Static"
#   sku = "Standard"
#   domain_name_label = "app1-vm-${random_string.myrandom.id}"
# }

resource "random_string" "myrandom" {
  length  = 8
  upper   = false
  special = false
}

# Resource-1: Create Public IP Address
resource "azurerm_public_ip" "web_linuxvm_publicip" {
  name                = "${var.resource_name_prefix}-web-linuxvm-publicip"
  resource_group_name = var.rg_group_name # azurerm_resource_group.rg.name
  location            = var.rg_location   # azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "app1-vm-${random_string.myrandom.id}"
}

# Resource-2: Create Network Interface
resource "azurerm_network_interface" "web_linuxvm_nic" {
  name                = "${var.resource_name_prefix}-web-linuxvm-nic"
  location            = var.rg_location
  resource_group_name = var.rg_group_name

  ip_configuration {
    name                          = "web-linuxvm-ip-1"
    subnet_id                     = var.websubnet_id # azurerm_subnet.websubnet.id 
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web_linuxvm_publicip.id
  }
}



