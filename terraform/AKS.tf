resource "azurerm_kubernetes_cluster" "kloud-aks-cluster" {
  name                = "${var.project_name}-aks1"
  location            = azurerm_resource_group.kloud-rg.location
  resource_group_name = azurerm_resource_group.kloud-rg.name
  dns_prefix          = "${var.project_name}aks"

  default_node_pool {
    name       = var.aks_nodepool_name
    node_count = var.aks_nodepool_count
    vm_size    = var.aks_vm_size
  }

  node_provisioning_profile { mode = "Auto" }

  identity { type = "SystemAssigned" }

  tags = var.tags
}
