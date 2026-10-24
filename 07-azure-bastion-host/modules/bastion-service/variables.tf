variable "rg_location" {
  type        = string
  description = "Resource Group Location"
}

variable "rg_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "resource_name_prefix" {
  type        = string
  description = "Resource Name prefix"
}

variable "bastion_service_subnet_id" {
  type        = string
  description = "Bastion Service Subnet ID"
}