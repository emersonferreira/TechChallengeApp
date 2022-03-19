output "subnet_id" {
  value = "${azurerm_kubernetes_cluster.aks_container.default_node_pool.0.vnet_subnet_id}"
}

output "network_plugin" {
  value = "${azurerm_kubernetes_cluster.aks_container.network_profile.0.network_plugin}"
}

output "service_cidr" {
  value = "${azurerm_kubernetes_cluster.aks_container.network_profile.0.service_cidr}"
}

output "dns_service_ip" {
  value = "${azurerm_kubernetes_cluster.aks_container.network_profile.0.dns_service_ip}"
}

output "docker_bridge_cidr" {
  value = "${azurerm_kubernetes_cluster.aks_container.network_profile.0.docker_bridge_cidr}"
}

output "pod_cidr" {
  value = "${azurerm_kubernetes_cluster.aks_container.network_profile.0.pod_cidr}"
}

output "pgsql_administrator_login" {
  value = "${azurerm_postgresql_server.servian.administrator_login}"
}

output "pgsql_administrator_login_password" {
  value = "${azurerm_postgresql_server.servian.administrator_login_password}"
  sensitive = true
}

output "pgsql_name" {
  value = "${azurerm_postgresql_server.servian.name}"
}

output "pgsql_location" {
  value = "${azurerm_postgresql_server.servian.location}"
}

output "acr_name" {
  value = "${azurerm_container_registry.acr.name}"
}
