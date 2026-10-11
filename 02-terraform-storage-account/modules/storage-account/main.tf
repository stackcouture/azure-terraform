resource "azurerm_storage_account" "example" {
  name                     = var.storage_account_name # "storageaccountname"
  resource_group_name      = var.rg_name              # azurerm_resource_group.example.name
  location                 = var.rg_location          # azurerm_resource_group.example.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  tags = {
    environment = var.environment
  }
}