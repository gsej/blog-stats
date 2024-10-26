resource "azurerm_application_insights" "appinsights" {
  name                = "appservice-appinsights"
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name
  application_type    = "web"
}