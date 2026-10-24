variable "rg_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "rg_location" {
  type        = string
  description = "Resource Group location"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID"
}

variable "web_subnet_name" {
  type        = string
  description = "Web Subnet Name"
}

# App Subnet Network Security Group 
variable "app_subnet_name" {
  type        = string
  description = "App Subnet Name"
}

variable "app_subnet_id" {
  type        = string
  description = "App Subnet ID"
}

# DB NSG 
variable "db_subnet_name" {
  type        = string
  description = "DB Subnet Name"
}

variable "db_subnet_id" {
  type        = string
  description = "DB Subnet ID"
}

# Bastion NSG
variable "bastion_subnet_name" {
  type        = string
  description = "Virtual Network Bastion Subnet Name"
}

variable "bastion_subnet_id" {
  type        = string
  description = "Bastion Subnet ID"
}

# variable "web_linuxvm_nic_name" {
#   type        = string
#   description = "Web Linux VM NIC Name"
# }

# variable "web_linuxvm_nic_id" {
#   type        = string
#   description = "Web linux VM NIC Id"
# }