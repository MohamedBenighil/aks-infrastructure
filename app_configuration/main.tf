locals {
  suffix_resource = format("%s-%s", var.name, var.environment)
}


data "azurerm_client_config" "current" {}


resource "azurerm_resource_group" "application" {
  name     = format("rg-%s", local.suffix_resource)
  location = var.location
}


#resource "azurerm_resource_group" "backend" {
#  name     = format("rg-%s-backend", local.suffix_resource)
#  location = var.location
#}


