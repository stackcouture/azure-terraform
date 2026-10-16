# Web Subnet 
variable "web_subnet_name" {
  type        = string
  description = "Virtual Network Web Subnet name"
}

variable "web_subnet_address" {
  type        = list(string)
  description = "Virutal Network Web Subnet Address"
}

variable "vnet_name" {
  type        = string
  description = "Virtula Network Name"
}

variable "rg_name" {
  type        = string
  description = "Resource Group Name"
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