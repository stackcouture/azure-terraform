resource "random_string" "myrandom" {
  length  = 8
  upper   = false
  special = false
}

resource "azurerm_public_ip" "web_linuxvm_publicip" {
  name                = "${var.resource_name_prefix}-web-linuxvm-publicip"
  resource_group_name = var.rg_group_name
  location            = var.rg_location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "app1-vm-${random_string.myrandom.id}"
  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_network_interface" "web_linuxvm_nic" {
  name                = "${var.resource_name_prefix}-web-linuxvm-nic"
  location            = var.rg_location
  resource_group_name = var.rg_group_name

  ip_configuration {
    name                          = "web-linuxvm-ip-1"
    subnet_id                     = var.websubnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web_linuxvm_publicip.id
  }
}


locals {
  webvm_custom_data = <<-CUSTOM_DATA
#!/bin/bash
set -euxo pipefail

exec > >(tee -a /var/log/webvm-custom-data.log) 2>&1

echo "Starting WebVM App1 setup..."

# Update Ubuntu packages
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get upgrade -y

# Install Apache
apt-get install -y apache2 curl ufw

# Enable and start Apache
systemctl enable --now apache2

# Configure Linux firewall
ufw allow OpenSSH
ufw allow 80/tcp
ufw --force enable

# Create application directories
mkdir -p /var/www/html/app1
chmod 755 /var/www/html /var/www/html/app1

# Create webpages
cat > /var/www/html/index.html <<EOF
Welcome to StackCouture - WebVM App1 - VM Hostname: $(hostname)
EOF

cat > /var/www/html/app1/hostname.html <<EOF
Welcome to StackCouture - WebVM App1 - VM Hostname: $(hostname)
EOF

cat > /var/www/html/app1/status.html <<EOF
Welcome to StackCouture - WebVM App1 - App Status Page
EOF

cat > /var/www/html/app1/index.html <<'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>StackCouture App1</title>
</head>
<body style="background-color:rgb(250, 210, 210);">
    <h1>Welcome to StackCouture - WebVM APP-1</h1>
    <p>Terraform Demo</p>
    <p>Application Version: V1</p>
</body>
</html>
EOF

# Set correct ownership
chown -R www-data:www-data /var/www/html/app1

# Verify Apache service and webpage
systemctl is-active apache2
curl -f http://localhost/

echo "WebVM App1 setup completed successfully."
CUSTOM_DATA
}

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
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
  custom_data = base64encode(local.webvm_custom_data)
}