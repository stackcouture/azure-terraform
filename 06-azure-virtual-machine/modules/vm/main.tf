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


# Locals Block for custom data
locals {
  webvm_custom_data = <<CUSTOM_DATA
#!/bin/sh
#sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd  
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo chmod -R 777 /var/www/html 
sudo echo "Welcome to StackCouture - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/index.html
sudo mkdir /var/www/html/app1
sudo echo "Welcome to StackCouture - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/app1/hostname.html
sudo echo "Welcome to StackCouture - WebVM App1 - App Status Page" > /var/www/html/app1/status.html
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to Stack Simplify - WebVM APP-1 </h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/app1/index.html
sudo curl -H "Metadata:true" --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2020-09-01" -o /var/www/html/app1/metadata.html
CUSTOM_DATA
}


# Resource: Azure Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "web_linuxvm" {
  name                  = "${var.resource_name_prefix}-web-linuxvm"
  resource_group_name   = var.rg_group_name
  location              = var.rg_location
  size                  = "Standard_DS1_v2"
  admin_username        = "azureuser"
  network_interface_ids = [azurerm_network_interface.web_linuxvm_nic.id]
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
  custom_data = base64encode(local.webvm_custom_data)
}



