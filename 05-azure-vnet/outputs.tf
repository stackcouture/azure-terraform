
output "resource_group_name" {
  value = module.resource_group.resource_group_name
}

output "vnet_id" {
  value = module.vnet.vnet_id
}

output "vnet_guid" {
  value = module.vnet.vnet_guid
}

# Web Subnet Id 
output "websubnet_id" {
  value = module.subnet.web_subnet_id
}