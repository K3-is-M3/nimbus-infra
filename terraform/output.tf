output "rg-name" {
  description = "Resource group name:"
  value       = azurerm_resource_group.kloud-rg.name
}

output "location" {
  description = "Deployment Location: "
  value       = var.location
}

output "storage-acc" {
  description = "Storage account name: "
  value       = azurerm_storage_account.kloud-storage.name
}

output "kloud-kv" {
  description = "Key Vault: "
  value       = azurerm_key_vault.kloud-kv.name
}

output "acr_name" {
  description = "Container Registry: "
  value       = azurerm_container_registry.kloud-acr.name
}

output "acr_login_server" {
  description = "The login server URL for the Azure Container Registry"
  value       = azurerm_container_registry.kloud-acr.login_server
}

output "acr_admin_username" {
  description = "The admin username for the Azure Container Registry"
  value       = azurerm_container_registry.kloud-acr.admin_username
}

output "aks_cluster_name" {
  description = "AKS cluster name"
  value       = azurerm_kubernetes_cluster.kloud-aks-cluster.name
}

output "aks_kubelet_id" {
  description = "AKS Kubelet identity"
  value       = azurerm_kubernetes_cluster.kloud-aks-cluster.kubelet_identity[0].object_id
}
