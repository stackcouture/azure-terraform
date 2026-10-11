
output "resource_group_name" {
  value = module.bootstrap.resource_group_name # azurerm_resource_group.tfstate.name
}

output "storage_account_name" {
  value = module.bootstrap.storage_account_name # azurerm_storage_account.tfstate.name
}

output "container_name" {
  value = module.bootstrap.container_name  # azurerm_storage_container.tfstate.name
}
