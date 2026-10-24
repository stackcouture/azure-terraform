resource "azurerm_network_interface" "web_linuxvm_nic" {
  name                = "${var.resource_name_prefix}-web-linuxvm-nic"
  location            = var.rg_location
  resource_group_name = var.rg_group_name

  ip_configuration {
    name                          = "web-linuxvm-ip-1"
    subnet_id                     = var.websubnet_id
    private_ip_address_allocation = "Dynamic"
  }
}