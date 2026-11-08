resource "azurerm_network_security_group" "web_vmss_nsg" {
  name                = "${var.resource_name_prefix}-web-vmss-nsg"
  location            = var.rg_location
  resource_group_name = var.rg_group_name

  dynamic "security_rule" {
    for_each = var.web_vmss_nsg_inbound_ports
    content {
      name                       = "inbound-rule-${security_rule.key}"
      description                = "Inbound Rule ${security_rule.key}"
      priority                   = sum([100, security_rule.key])
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
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

# Resource: Azure Linux Virtual Machine Scale Set - App1
resource "azurerm_linux_virtual_machine_scale_set" "web_vmss" {
  name                = "${var.resource_name_prefix}-web-vmss"
  resource_group_name = var.rg_group_name
  location            = var.rg_location
  sku                 = "Standard_DS1_v2"
  instances           = 2
  admin_username      = "azureuser"

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("ssh-keys/terraform-azure.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  upgrade_mode = "Automatic"

  network_interface {
    name                      = "web-vmss-nic"
    primary                   = "true"
    network_security_group_id = azurerm_network_security_group.web_vmss_nsg.id
    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = var.websubnet_id                   # azurerm_subnet.websubnet.id 
      load_balancer_backend_address_pool_ids = [var.web_lb_backend_address_pool_id] # [azurerm_lb_backend_address_pool.web_lb_backend_address_pool.id]
    }
  }

  custom_data = base64encode(local.webvm_custom_data)
}