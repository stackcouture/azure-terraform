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

