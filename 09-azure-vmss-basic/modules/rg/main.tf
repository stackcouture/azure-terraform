resource "azurerm_resource_group" "resource_group" {
  name     = var.rg_name
  location = var.location_name
  tags     = var.common_tags
}