module "resource_group" {
  source        = "./modules/rg"
  rg_name       = var.rg_name
  location_name = var.location_name
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

module "subnet" {
  source    = "./modules/subnet"
  rg_name   = module.resource_group.resource_group_name
  vnet_name = "${local.resource_name_prefix}-${var.vnet_name}"

  # Web Subnet
  web_subnet_name    = var.web_subnet_name
  web_subnet_address = var.web_subnet_address

  # App Subnet 
  app_subnet_name    = var.app_subnet_name
  app_subnet_address = var.app_subnet_address

  # DB Subnet
  db_subnet_name    = var.db_subnet_name
  db_subnet_address = var.db_subnet_address
}

module "nsg" {
  source        = "./modules/nsg"
  rg_location   = module.resource_group.resource_group_location_name
  rg_group_name = module.resource_group.resource_group_name

  subnet_id       = module.subnet.web_subnet_id
  web_subnet_name = var.web_subnet_name

  app_subnet_id   = module.subnet.app_subnet_id
  app_subnet_name = var.app_subnet_name
}