output "web_linuxvm_nic_name" {
  value = azurerm_network_interface.web_linuxvm_nic.name
}

output "web_linuxvm_nic_id" {
  value = azurerm_network_interface.web_linuxvm_nic.id
}

# Linux VM Outputs

output "web_linuxvm_public_ip_address" {
  description = "Web Linux Virtual Machine Public IP"
  value       = azurerm_linux_virtual_machine.web_linuxvm.public_ip_address
}

output "web_linuxvm_private_ip_address" {
  description = "Web Linux Virtual Machine Private IP"
  value       = azurerm_linux_virtual_machine.web_linuxvm.private_ip_address
}

output "web_linuxvm_virtual_machine_id_128bit" {
  description = "Web Linux Virtual Machine ID - 128-bit identifier"
  value       = azurerm_linux_virtual_machine.web_linuxvm.virtual_machine_id
}

output "web_linuxvm_virtual_machine_id" {
  description = "Web Linux Virtual Machine ID "
  value       = azurerm_linux_virtual_machine.web_linuxvm.id
}
