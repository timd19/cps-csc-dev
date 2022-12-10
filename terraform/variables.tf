variable "name_prefix" {
  type        = string
  description = "Prefix of the resource name"
}

variable "location" {
  type        = string
  description = "Location to deploy the resource group"
  default     = "West US 2"
}

variable "subscription_id" {
  type        = string
  description = "subscription_id"
}

variable "tenant_id" {
  type        = string
  description = "tenant_id"
}

variable "client_id" {
  type        = string
  description = "client_id"
}

variable "client_secret" {
  type        = string
  description = "client_secret"
}
