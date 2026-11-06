module "resource_group" {
  source        = "./modules/rg"
  rg_name       = var.rg_name
  location_name = var.location_name
  common_tags   = local.common_tags
}