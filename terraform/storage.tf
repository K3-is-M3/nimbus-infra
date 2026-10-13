resource "azurerm_storage_account" "kloud-storage" {
  name                     = "kloudstorageacc1"
  resource_group_name      = azurerm_resource_group.kloud-rg.name
  location                 = azurerm_resource_group.kloud-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

resource "azurerm_storage_container" "kloud-storage-container" {
  name                  = "container1"
  storage_account_id    = azurerm_storage_account.kloud-storage.id
  container_access_type = "private"
}
