resource "azurerm_resource_group" "kloud-rg" {
  name     = var.project_name
  location = var.location
}

