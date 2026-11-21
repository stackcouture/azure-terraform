output "bastion_vm_ip_address" {
  description = "Bastion Host Linux VM Public Address"
  value       = azurerm_public_ip.bastion_host_publicip.ip_address
}