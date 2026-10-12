variable "account_tier" {
  type        = string
  description = "Account Tier"
}

variable "account_replication_type" {
  type        = string
  description = "Account Replication Type"
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "rg_name" {
  type        = string
  description = "Resource Group name"
}

variable "rg_location" {
  type        = string
  description = "Resource Group Location"
}

variable "storage_account_name" {
  type        = string
  description = "Storage Account Name"
}