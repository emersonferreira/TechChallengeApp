terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }

  backend "azurerm" {
        resource_group_name  = "servian"
        storage_account_name = "strservian"
        container_name       = "servian-tfstate"
        key                  = "servian-terraform.tfstate"
    }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  # NOTE: Environment Variables can also be used for Service Principal authentication
  # Terraform also supports authenticating via the Azure CLI too.
  # see here for more info: http://terraform.io/docs/providers/azurerm/index.html

  features {}
}

resource "azurerm_resource_group" "akc-rg" {
  name     = "${var.resource_group_name}"
  location = "${var.resource_group_location}"
}

resource azurerm_network_security_group "aks_advanced_network" {
  name                = "akc-${var.fix_number}-nsg"
  location            = "${var.resource_group_location}"
  resource_group_name = "${azurerm_resource_group.akc-rg.name}"
}

resource "azurerm_virtual_network" "aks_advanced_network" {
  name                = "akc-${var.fix_number}-vnet"
  location            = "${var.resource_group_location}"
  resource_group_name = "${azurerm_resource_group.akc-rg.name}"
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "aks_subnet" {
  name                      = "akc-aks-${var.fix_number}-subnet"
  resource_group_name       = "${azurerm_resource_group.akc-rg.name}"
  address_prefixes          = "${var.address_prefixes_aks}"
  virtual_network_name      = "${azurerm_virtual_network.aks_advanced_network.name}"
}

resource "azurerm_subnet" "postgresql_subnet" {
  name                      = "akc-db-${var.fix_number}-subnet"
  resource_group_name       = "${azurerm_resource_group.akc-rg.name}"
  address_prefixes          = "${var.address_prefixes_pgsql}"
  virtual_network_name      = "${azurerm_virtual_network.aks_advanced_network.name}"
}

resource "azurerm_kubernetes_cluster" "aks_container" {
  name       = "${var.aks-name}"
  location   = "${var.resource_group_location}"
  dns_prefix = "akc-${var.fix_number}"

  resource_group_name = "${azurerm_resource_group.akc-rg.name}"

  default_node_pool {
    name       = "${var.default_node_pool_name}"
    node_count = "${var.default_node_pool_node_count}"
    vm_size    = "${var.default_node_pool_vm_size}"

    # Required for advanced networking
    vnet_subnet_id = "${azurerm_subnet.aks_subnet.id}"
  }

  service_principal {
    client_id     = "${var.client_id}"
    client_secret = "${var.client_secret}"
  }

  network_profile {
    network_plugin     = "${var.aks_container_network_plugin}"
    dns_service_ip     = "${var.aks_container_dns_service_ip}"
    docker_bridge_cidr = "${var.aks_container_docker_bridge_cidr}"
    service_cidr       = "${var.aks_container_service_cidr}"
  }
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.aks_acr_name}${var.fix_number}"
  resource_group_name = "${azurerm_resource_group.akc-rg.name}"
  location            = "${var.resource_group_location}"
  sku                 = "Standard"
  admin_enabled       = true
}

resource "azurerm_postgresql_server" "servian" {
  name                = "${var.pgsql_database_name}"
  location            = "${azurerm_resource_group.akc-rg.location}"
  resource_group_name = "${azurerm_resource_group.akc-rg.name}"

  sku_name = "${var.pgsql_database_sku_name}"

  storage_mb                   = "${var.storage_mb}"
  backup_retention_days        = "${var.backup_retention_days}"
  geo_redundant_backup_enabled = "${var.geo_redundant_backup_enabled}"
  auto_grow_enabled            = "${var.auto_grow_enabled}"

  administrator_login          = "${var.administrator_login}"
  administrator_login_password = "${var.administrator_login_password}"
  version                      = "${var.pgsql_version}"
  ssl_enforcement_enabled      = "${var.ssl_enforcement_enabled}"
}

resource "azurerm_postgresql_firewall_rule" "azure_resource_access" {
  name                = "azure-pgsql-access"
  resource_group_name = "${azurerm_resource_group.akc-rg.name}"
  server_name         = azurerm_postgresql_server.servian.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}