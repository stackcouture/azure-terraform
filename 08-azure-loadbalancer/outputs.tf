output "resource_group_name" {
  description = "Resource Group Name"
  value       = module.resource_group.resource_group_name
}

output "vnet_id" {
  description = "Virtual Network ID"
  value       = module.vnet.vnet_id
}

output "vnet_guid" {
  description = "Virtual Network GUID"
  value       = module.vnet.vnet_guid
}

# Web Subnet Id 
output "websubnet_id" {
  description = "Web Subnet ID"
  value       = module.subnet.web_subnet_id
}

# App Subnet ID
output "appsubnet_id" {
  description = "App Subnet ID"
  value       = module.subnet.app_subnet_id
}

# App Subnet ID
output "dbsubnet_id" {
  description = "DB Subnet ID"
  value       = module.subnet.db_subnet_id
}

output "bastion_subnet_id" {
  description = "Bastion Subnet ID"
  value       = module.subnet.bastion_subnet_id
}

# NSG Output 
output "web_subnet_nsg_name" {
  description = "Web Subnet NSG name"
  value       = module.nsg.web_subnet_nsg_name
}

output "web_subnet_nsg_id" {
  description = "Web Subnet NSG ID"
  value       = module.nsg.web_subnet_nsg_id
}

output "web_linuxvm_nic_name" {
  value = module.vm.web_linuxvm_nic_name
}

output "web_linuxvm_public_ip_address" {
  description = "Web Linux Virtual Machine Public IP"
  value       = module.vm.web_linuxvm_public_ip_address
}

output "web_linuxvm_private_ip_address" {
  description = "Web Linux Virtual Machine Private IP"
  value       = module.vm.web_linuxvm_private_ip_address
}

output "web_linuxvm_virtual_machine_id_128bit" {
  description = "Web Linux Virtual Machine ID - 128-bit identifier"
  value       = module.vm.web_linuxvm_virtual_machine_id_128bit
}

output "web_linuxvm_virtual_machine_id" {
  description = "Web Linux Virtual Machine ID "
  value       = module.vm.web_linuxvm_virtual_machine_id
}

# Load Balancer Output 
# LB Public IP
output "web_lb_public_ip_address" {
  description = "Web Load Balancer Public Address"
  value       = module.lb.web_lb_public_ip_address
}

# Load Balancer ID
output "web_lb_id" {
  description = "Web Load Balancer ID."
  value       = module.lb.web_lb_id
}

# Load Balancer Frontend IP Configuration Block
output "web_lb_frontend_ip_configuration" {
  description = "Web LB frontend_ip_configuration Block"
  value       = module.lb.web_lb_frontend_ip_configuration # [azurerm_lb.web_lb.frontend_ip_configuration]
}