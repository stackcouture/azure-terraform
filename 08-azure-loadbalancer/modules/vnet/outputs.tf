output "vnet_name" {
  description = "Virtual Network name"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  description = "Virtual Network ID"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_guid" {
  description = "Virtual Network GUID"
  value       = azurerm_virtual_network.vnet.guid
}