resource "azurerm_public_ip" "bastion_host_publicip" {
  name                = "${var.resource_name_prefix}-bastion-host-publicip"
  resource_group_name = var.rg_group_name
  location            = var.rg_location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "bastion_host_linuxvm_nic" {
  name                = "${var.resource_name_prefix}-bastion-host-linuxvm-nic"
  location            = var.rg_location
  resource_group_name = var.rg_group_name

  ip_configuration {
    name                          = "bastion-host-ip-1"
    subnet_id                     = var.bastion_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion_host_publicip.id
  }
}

resource "azurerm_linux_virtual_machine" "bastion_host_linuxvm" {
  name                  = "${var.resource_name_prefix}-bastion-linuxvm"
  resource_group_name   = var.rg_group_name
  location              = var.rg_location
  size                  = "Standard_DS1_v2"
  admin_username        = "azureuser"
  network_interface_ids = [azurerm_network_interface.bastion_host_linuxvm_nic.id]
  admin_ssh_key {
    username   = "azureuser"
    public_key = file("ssh-keys/terraform-azure.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "83-gen2"
    version   = "latest"
  }
}
