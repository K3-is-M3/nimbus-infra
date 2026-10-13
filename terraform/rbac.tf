resource "azurerm_role_assignment" "AcrPull" {
  principal_id                     = azurerm_kubernetes_cluster.kloud-aks-cluster.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.kloud-acr.id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "kloud-kv-secrets-officer" {
  principal_id         = azurerm_kubernetes_cluster.kloud-aks-cluster.identity[0].principal_id
  role_definition_name = "Key Vault Secrets Officer"
  scope                = azurerm_container_registry.kloud-acr.id
}
