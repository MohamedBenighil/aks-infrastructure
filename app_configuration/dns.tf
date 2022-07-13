#Private dns zone
##aks


data "azurerm_resource_group" "common" {
  name = format("%s-common-rg", var.name)
}

data "azurerm_private_dns_zone" "aks_dns_zone" {
  name                = "privatelink.${data.azurerm_resource_group.common.location}.azmk8s.io"
  resource_group_name = data.azurerm_resource_group.common.name
}

##keyvault
data "azurerm_private_dns_zone" "keyvault_dns_zone" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = data.azurerm_resource_group.common.name
}


##storage account

##acr
data "azurerm_private_dns_zone" "acr_dns_zone" {
  name                = "privatelink.azurecr.io"
  resource_group_name = data.azurerm_resource_group.common.name
}
# VNET Link
