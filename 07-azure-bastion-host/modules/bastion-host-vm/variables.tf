variable "resource_name_prefix" {
  type        = string
  description = "Resource Name prefix"
}

variable "rg_location" {
  type        = string
  description = "Resource Group Location"
}

variable "rg_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "bastion_subnet_id" {
  type        = string
  description = "Bastion Subnet ID"
}

# variable "bastion_service_subnet_name" {
#   description = "Bastion Service Subnet Name"
#   default = "AzureBastionSubnet"
# }

# variable "bastion_service_address_prefixes" {
#   description = "Bastion Service Address Prefixes"
#   default = ["10.0.101.0/27"]
# }