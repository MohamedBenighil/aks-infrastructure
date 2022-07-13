
#principale aks identity
module "principal_aks" {
  source         = "../modules/identity"
  resource_name  = format("aks-principal-%s", local.suffix_resource)
  resource_group = azurerm_resource_group.application
}

#kubelet aks identity
module "kubelet_aks" {
  source         = "../modules/identity"
  resource_name  = format("aks-kubelet-%s", local.suffix_resource)
  resource_group = azurerm_resource_group.application
}


module "agw_keyvault" {
  count          = var.agic_enabled ? 1 : 0
  source         = "../modules/identity"
  resource_name  = format("agw-keyvault-%s", local.suffix_resource)
  resource_group = azurerm_resource_group.application
}


