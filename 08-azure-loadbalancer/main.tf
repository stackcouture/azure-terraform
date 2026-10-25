module "resource_group" {
  source        = "./modules/rg"
  rg_name       = var.rg_name
  location_name = var.location_name
  common_tags   = local.common_tags
}

module "vnet" {
  source               = "./modules/vnet"
  resource_name_prefix = local.resource_name_prefix
  vnet_name            = var.vnet_name
  vnet_address_space   = var.vnet_address_space
  rg_location          = module.resource_group.resource_group_location_name
  rg_group_name        = module.resource_group.resource_group_name
  common_tags          = local.common_tags
}