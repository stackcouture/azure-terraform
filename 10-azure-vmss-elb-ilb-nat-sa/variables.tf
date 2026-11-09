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