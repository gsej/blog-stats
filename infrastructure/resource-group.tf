resource "azurerm_resource_group" "group" {
  name     = var.service-name
  location = var.location
}