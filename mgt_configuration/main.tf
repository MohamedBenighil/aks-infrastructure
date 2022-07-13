locals {
  suffix_resource = format("%s", var.name)
}


data "azurerm_client_config" "current" {}

#TODO move into another configuration
resource "azurerm_resource_group" "bastion" {
  name     = format("%s-bastion-rg", var.name)
  location = var.location
}
resource "azurerm_resource_group" "common" {
  name     = format("%s-common-rg", var.name)
  location = var.location
}
