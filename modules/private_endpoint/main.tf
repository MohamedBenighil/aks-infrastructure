locals {
   pe_name = format("pe-%s", var.name)
   vnet_link_name = format("vnet-link-%s", var.name)
}


resource "azurerm_private_dns_zone_virtual_network_link" "dns_zone_vnet_link" {
  name                  = local.vnet_link_name
  resource_group_name   = var.private_dns_zone.resource_group_name
  private_dns_zone_name = var.private_dns_zone.name
  virtual_network_id    =  var.subnet_virtual_network.private_virtual_network_id
  registration_enabled  = "false"
}



# Private endpoint 
resource "azurerm_private_endpoint" "pe" {
  name                                           = local.pe_name
  resource_group_name                            = var.azure_resource_group.name
  location = var.azure_resource_group.location
  subnet_id =  var.subnet_virtual_network.private_subnet_id
 
  private_dns_zone_group {
    name                 = format("pdnsz-%s",var.resource.name)
    private_dns_zone_ids = [var.private_dns_zone.id]
  }

  private_service_connection {
    name                           = format("psc-%s",var.resource.name)
    is_manual_connection           = false
    private_connection_resource_id = var.resource.id
    subresource_names = var.subresource_names
  }

}
