resource "azurerm_user_assigned_identity" "identity" {
  name                = format("id-%s", var.resource_name)
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
}
