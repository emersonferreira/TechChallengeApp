aks-name      = "aks-servian"
resource_group_name = "rg-servian"
resource_group_location = "eastus2"
client_id = "e75e800b-30d1-46aa-ac7b-dbca97cde196"
client_secret = "BT57Q~G1dXoEL95ZcWAlfACFsD1xrPskC9v~1"

storage_mb = "5120"
backup_retention_days = "7"
geo_redundant_backup_enabled = "false"
auto_grow_enabled = "true"
administrator_login = "psqladminuser"
administrator_login_password = "H@Sh1CoR3! "
pgsql_version = "11"
ssl_enforcement_enabled = "false"
allow_access_to_azure_services = "true"
address_prefixes_aks = ["10.1.0.0/24"]
address_prefixes_pgsql = ["10.1.1.0/24"]

aks_container_network_plugin     = "azure"
aks_container_dns_service_ip     = "10.0.0.10"
aks_container_docker_bridge_cidr = "172.17.0.1/16"
aks_container_service_cidr       = "10.0.0.0/16"

aks_acr_name = "servianacr"

default_node_pool_name = "default"
default_node_pool_node_count = 2
default_node_pool_vm_size = "Standard_DS2_v2"

pgsql_database_name = "postgresql-servian"
pgsql_database_sku_name = "B_Gen5_2"