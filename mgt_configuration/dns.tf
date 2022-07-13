#Private dns zone
##aks
module "aks_dns_zone" {
  source               = "../modules/private_dns_zone"
  domain               = "privatelink.${var.location}.azmk8s.io"
  azure_resource_group = azurerm_resource_group.common
  tags                 = var.tags
}
##keyvault
module "keyvault_dns_zone" {
  source               = "../modules/private_dns_zone"
  domain               = "privatelink.vaultcore.azure.net"
  azure_resource_group = azurerm_resource_group.common
  tags                 = var.tags
}
##storage account

##acr
module "acr_dns_zone" {
  source               = "../modules/private_dns_zone"
  domain               = "privatelink.azurecr.io"
  azure_resource_group = azurerm_resource_group.common
  tags                 = var.tags
}

# VNET Link


module "acr_vnet_link_admin_vnet" {
  source                     = "../modules/vnet_link"
  name                       = "bation-acr-${local.suffix_resource}"
  private_dns_zone           = module.acr_dns_zone
  private_virtual_network_id = azurerm_virtual_network.bastion.id
  azure_resource_group       = azurerm_resource_group.common
  tags                       = var.tags
}


module "aks_vnet_link_admin_vnet" {
  source                     = "../modules/vnet_link"
  name                       = "bation-aks-${local.suffix_resource}"
  private_dns_zone           = module.aks_dns_zone
  private_virtual_network_id = azurerm_virtual_network.bastion.id
  azure_resource_group       = azurerm_resource_group.common

  tags = var.tags
}


module "kv_vnet_link_admin_vnet" {
  source                     = "../modules/vnet_link"
  name                       = "bation-kv-${local.suffix_resource}"
  private_dns_zone           = module.keyvault_dns_zone
  private_virtual_network_id = azurerm_virtual_network.bastion.id
  azure_resource_group       = azurerm_resource_group.common

  tags = var.tags
}
