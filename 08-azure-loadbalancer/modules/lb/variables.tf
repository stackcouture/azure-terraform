variable "resource_name_prefix" {
  type        = string
  description = "Resource Name prefix"
}

variable "common_tags" {
  type        = map(string)
  description = "Load Balancer Common Tags"
}

variable "rg_location" {
  type        = string
  description = "Resource Group Location"
}

variable "rg_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "web_linuxvm_nic_id" {
  type        = string
  description = "Web Linux VM NIC Id"
}

variable "web_linuxvm_nic_ip_configuration_name" {
  type        = string
  description = "Web Linux VM NIC Ip Configuration name"
}

