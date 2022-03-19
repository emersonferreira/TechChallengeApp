variable "aks-name" {
  type        = string
  description = "Name of this cluster."
  default     = "akc-example"
}

variable "client_id" {
  type        = string
  description = "Client ID"
}

variable "client_secret" {
  type        = string
  description = "Client secret."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the azure resource group."
  default     = "akc-rg"
}

variable "resource_group_location" {
  type        = string
  description = "Location of the azure resource group."
  default     = "eastus"
}

variable "storage_mb" {
  type        = number
}

variable "backup_retention_days" {
  type        = number
}

variable "geo_redundant_backup_enabled" {
  type        = bool
}

variable "auto_grow_enabled" {
  type        = bool
}

variable "administrator_login" {
  type        = string
}

variable "administrator_login_password" {
  type        = string
}

variable "pgsql_version" {
  type        = string
}

variable "ssl_enforcement_enabled" {
  type        = bool
}

variable "allow_access_to_azure_services" {
  type        = bool
}

variable "aks_container_network_plugin" {
  type        = string
}

variable "aks_container_dns_service_ip" {
  type        = string
}

variable "aks_container_docker_bridge_cidr" {
  type        = string
}

variable "aks_container_service_cidr" {
  type        = string
}

variable "default_node_pool_name" {
  type        = string
}

variable "default_node_pool_node_count" {
  type        = number
}

variable "default_node_pool_vm_size" {
  type        = string
}

variable "address_prefixes_aks" {
  type        = list
}

variable "address_prefixes_pgsql" {
  type        = list
}

variable "pgsql_database_name" {
  type        = string
}

variable "pgsql_database_sku_name" {
  type        = string
}

variable "aks_acr_name" {
  type        = string
}

variable "fix_number" {
  type        = number
}
