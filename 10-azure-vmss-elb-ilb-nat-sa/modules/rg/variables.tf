variable "rg_name" {
  type        = string
  description = "Resource Group name"
}

variable "location_name" {
  type        = string
  description = "Location name"
}

variable "common_tags" {
  type        = map(string)
  description = "Virutal Network Common Tags"
}