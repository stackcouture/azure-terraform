output "bastion_vm_ip_address" {
  description = "Bastion Host Linux VM Public Address"
  value       = azurerm_public_ip.bastion_host_publicip.ip_address
}

output "bastion_linuxvm_nic_name" {
  value = azurerm_network_interface.bastion_host_linuxvm_nic.name
}

output "bastion_linuxvm_nic_id" {
  value = azurerm_network_interface.bastion_host_linuxvm_nic.id
}

# Linux VM Outputs

output "bastion_linuxvm_public_ip_address" {
  description = "Web Linux Virtual Machine Public IP"
  value       = azurerm_linux_virtual_machine.bastion_host_linuxvm.public_ip_address
}

output "bastion_linuxvm_private_ip_address" {
  description = "Web Linux Virtual Machine Private IP"
  value       = azurerm_linux_virtual_machine.bastion_host_linuxvm.private_ip_address
}

output "bastion_linuxvm_virtual_machine_id_128bit" {
  description = "Web Linux Virtual Machine ID - 128-bit identifier"
  value       = azurerm_linux_virtual_machine.bastion_host_linuxvm.virtual_machine_id
}

output "bastion_linuxvm_virtual_machine_id" {
  description = "Web Linux Virtual Machine ID "
  value       = azurerm_linux_virtual_machine.bastion_host_linuxvm.id
}

output "bastion_linuxvm_nic_ip_configuration_name" {
  description = "Web Linux VM NIC IP configuration name"
  value       = azurerm_network_interface.bastion_host_linuxvm_nic.ip_configuration[0].name
}