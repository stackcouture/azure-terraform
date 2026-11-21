
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

output "bastion_linuxvm_public_ip_address" {
  description = "Web Linux Virtual Machine Public IP"
  value       = module.bastion_host_vm.bastion_linuxvm_public_ip_address
}

output "bastion_linuxvm_private_ip_address" {
  description = "Web Linux Virtual Machine Private IP"
  value       = module.bastion_host_vm.bastion_linuxvm_private_ip_address
}

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
  value       = module.lb.web_lb_frontend_ip_configuration
}

# output "web_vmss_id" {
#   description = "Web Virtual Machine Scale Set ID"
#   value       = module.vmss.web_vmss_id
# }