variable "business_division" {
  type        = string
  description = "Business Division in the large organization"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

# Resource Group 
variable "rg_name" {
  type        = string
  description = "Resource Group name"
}

variable "location_name" {
  type        = string
  description = "Location name"
}

# Virtual Network  
variable "vnet_name" {
  type        = string
  description = "Virtual Network name"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Virtual Netowrk Address Space"
}

# Web Subnet 
variable "web_subnet_name" {
  type        = string
  description = "Virtual Network Web Subnet name"
}

variable "web_subnet_address" {
  type        = list(string)
  description = "Virutal Network Web Subnet Address"
}

# App Subnet Varaibles
variable "app_subnet_name" {
  type        = string
  description = "App Subnet name"
}

variable "app_subnet_address" {
  type        = list(string)
  description = "App Subnet Address"
}

# Database Subnet Name
variable "db_subnet_name" {
  type        = string
  description = "Virtual Network Database Subnet Name"
}

# Database Subnet Address Space
variable "db_subnet_address" {
  type        = list(string)
  description = "Virtual Network Database Subnet Address Spaces"
}

# Bastion Subnet Name
variable "bastion_subnet_name" {
  type        = string
  description = "Virtual Network Bastion Subnet Name"
}

# Bastion Subnet Address Space
variable "bastion_subnet_address" {
  type        = list(string)
  description = "Virtual Network Bastion Subnet Address Spaces"
}

# # Linux VM Input Variables Placeholder file.
# variable "web_vmss_nsg_inbound_ports" {
#   description = "Web VMSS NSG Inbound Ports"
#   type        = list(string)
# }


# Storage Account
# Input variable definitions
variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "storage_account_tier" {
  description = "Storage Account Tier"
  type        = string
}

variable "storage_account_replication_type" {
  description = "Storage Account Replication Type"
  type        = string
}

variable "storage_account_kind" {
  description = "Storage Account Kind"
  type        = string
}

variable "static_website_index_document" {
  description = "static website index document"
  type        = string
}

variable "static_website_error_404_document" {
  description = "static website error 404 document"
  type        = string
}


