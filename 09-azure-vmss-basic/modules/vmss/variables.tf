# Linux VM Input Variables Placeholder file.
variable "web_vmss_nsg_inbound_ports" {
  description = "Web VMSS NSG Inbound Ports"
  type        = list(string)
  default     = [22, 80, 443]
}

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

variable "websubnet_id" {
  type        = string
  description = "Web Subnet ID"
}

variable "web_lb_backend_address_pool_id" {
  type        = string
  description = "Web Load Balaner Backend Address Pool ID"
}