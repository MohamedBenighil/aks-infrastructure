
locals {
  subnet = format("snet-%s-%s",var.identifier_name, replace(var.virtual_network.name,"vnet-",""))
}


resource "azurerm_subnet" "subnet" {
  name                 = var.disable_naming_convention == true ? var.identifier_name : local.subnet
  resource_group_name  = var.virtual_network.resource_group_name
  virtual_network_name = var.virtual_network.name
  address_prefixes     = [var.subnet_address_prefixes]

    dynamic "delegation" {
    for_each = length( var.delegation) > 0 ? var.delegation: []
    content {
      name = delegation.value["name"]

     service_delegation {
 
          name    = delegation.value["service_delegation"]["name"]
          actions = try(delegation.value["service_delegation"]["actions"], null)
        }
      
    }
  }
}
