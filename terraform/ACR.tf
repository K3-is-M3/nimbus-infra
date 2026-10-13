resource "azurerm_container_registry" "kloud-acr" {
  name                = "${var.project_name}registry1"
  resource_group_name = azurerm_resource_group.kloud-rg.name
  location            = azurerm_resource_group.kloud-rg.location
  sku                 = var.acr_sku
  admin_enabled       = false
}
