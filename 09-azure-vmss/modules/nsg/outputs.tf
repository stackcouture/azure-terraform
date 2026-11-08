output "web_subnet_nsg_name" {
  description = "WebTier Subnet NSG Name"
  value       = azurerm_network_security_group.web_subnet_nsg.name
}

## Web Subnet NSG ID 
output "web_subnet_nsg_id" {
  description = "WebTier Subnet NSG ID"
  value       = azurerm_network_security_group.web_subnet_nsg.id
}