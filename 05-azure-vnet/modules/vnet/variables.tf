variable "resource_name_prefix" {
  type        = string
  description = "Resource Name prefix"
}

variable "vnet_name" {
  type        = string
  description = "Virtual Network Name"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Virtual Network Address Space"
}

variable "common_tags" {
  type        = map(string)
  description = "Virutal Network Common Tags"
}

variable "rg_location" {
  type        = string
  description = "Resource Group Location"
}

variable "rg_group_name" {
  type        = string
  description = "Resource Group Name"
}
