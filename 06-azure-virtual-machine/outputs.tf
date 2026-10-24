
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