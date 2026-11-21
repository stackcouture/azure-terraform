resource "random_string" "myrandom" {
  length  = 8
  upper   = false
  special = false
}

# Resource-1: Create Azure Storage account
resource "azurerm_storage_account" "storage_account" {
  name                = "${var.storage_account_name}${random_string.myrandom.id}"
  resource_group_name = var.rg_group_name

  location                 = var.rg_location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type

  #   account_kind             = var.storage_account_kind

  #   static_website {
  #     index_document     = var.static_website_index_document
  #     error_404_document = var.static_website_error_404_document
  #   }
}

resource "azurerm_storage_account_static_website" "example" {
  storage_account_id = azurerm_storage_account.storage_account.id
  error_404_document = var.static_website_error_404_document
  index_document     = var.static_website_index_document
}

# Resource-2: httpd files Container
resource "azurerm_storage_container" "httpd_files_container" {
  name = "httpd-files-container"
  # storage_account_name  = azurerm_storage_account.storage_account.name
  storage_account_id    = azurerm_storage_account.storage_account.id
  container_access_type = "private"
}

# Locals Block with list of files to be uploaded
locals {
  httpd_conf_files = ["app1.conf"]
}

# Resource-3: httpd conf files upload to httpd-files-container
resource "azurerm_storage_blob" "httpd_files_container_blob" {
  for_each = toset(local.httpd_conf_files)

  name                 = each.value
  storage_container_id = azurerm_storage_container.httpd_files_container.id

  type   = "Block"
  source = "${path.root}/app-scripts/${each.value}"
}

