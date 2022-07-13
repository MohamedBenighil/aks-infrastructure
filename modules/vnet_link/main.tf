locals {
   vnet_link_name = format("vnet-link-%s", var.name)
}


resource "azurerm_private_dns_zone_virtual_network_link" "dns_zone_vnet_link" {
  name                  = local.vnet_link_name
  resource_group_name   = var.azure_resource_group.name
  private_dns_zone_name = var.private_dns_zone.name
  virtual_network_id    = var.private_virtual_network_id
  registration_enabled  = "false"
}
