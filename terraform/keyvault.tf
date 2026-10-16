resource "azurerm_key_vault" "kloud-kv" {
  name                        = "kloud-keyvault"
  location                    = var.location
  resource_group_name         = azurerm_resource_group.kloud-rg.name
  rbac_authorization_enabled  = false
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = var.kv_sku

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
  }
}


