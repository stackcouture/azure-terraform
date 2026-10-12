module "resource_group" {
  source        = "./modules/rg"
  rg_name       = var.rg_name
  location_name = var.location_name
}

module "storage_account" {
  source                   = "./modules/storage-account"
  rg_name                  = module.resource_group.resource_group_name
  rg_location              = module.resource_group.resource_group_location_name
  storage_account_name     = var.storage_account_name
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  environment              = var.environment
}