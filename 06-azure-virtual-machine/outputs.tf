
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
  value       = module.vm.web_linuxvm_public_ip_address # azurerm_linux_virtual_machine.web_linuxvm.public_ip_address
}

output "web_linuxvm_private_ip_address" {
  description = "Web Linux Virtual Machine Private IP"
  value       = module.vm.web_linuxvm_private_ip_address # azurerm_linux_virtual_machine.web_linuxvm.private_ip_address
}

output "web_linuxvm_virtual_machine_id_128bit" {
  description = "Web Linux Virtual Machine ID - 128-bit identifier"
  value       = module.vm.web_linuxvm_virtual_machine_id_128bit # azurerm_linux_virtual_machine.web_linuxvm.virtual_machine_id
}

output "web_linuxvm_virtual_machine_id" {
  description = "Web Linux Virtual Machine ID "
  value       = module.vm.web_linuxvm_virtual_machine_id # azurerm_linux_virtual_machine.web_linuxvm.id
}
