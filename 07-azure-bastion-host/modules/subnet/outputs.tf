output "web_subnet_id" {
  value = azurerm_subnet.web_subnet.id
}

output "app_subnet_id" {
  value = azurerm_subnet.app_subnet.id
}

output "db_subnet_id" {
  value = azurerm_subnet.db_subnet.id
}

output "bastion_subnet_id" {
  value = azurerm_subnet.bastion_subnet.id
}

output "bastion_service_subnet_id" {
  value = azurerm_subnet.bastion_service_subnet.id
}