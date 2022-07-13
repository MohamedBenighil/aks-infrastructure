# Assign Acr pull premision to kubelet
resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id                     = module.principal_aks.principal_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}

# AKS DNS Contributor
resource "azurerm_role_assignment" "aks_dns_zone_contributor" {
  scope                = data.azurerm_private_dns_zone.aks_dns_zone.id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = module.principal_aks.principal_id
}
resource "azurerm_role_assignment" "aks_dns_zone_network_contributor" {
  scope                = azurerm_virtual_network.application.id
  role_definition_name = "Network contributor"
  principal_id         = module.principal_aks.principal_id
}

resource "azurerm_role_assignment" "aks_kubelet_owner_contributor" {
  scope                = module.kubelet_aks.id
  role_definition_name = "owner"
  principal_id         = module.principal_aks.principal_id
}

#AGIC

data "azurerm_user_assigned_identity" "aks_agic_idenity" {
  count               = var.agic_enabled ? 1 : 0
  name                = format("ingressapplicationgateway-%s", local.aks_name)
  resource_group_name = local.aks_rg_name
  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]
}

resource "azurerm_role_assignment" "agw_contributor" {
  count                = var.agic_enabled ? 1 : 0
  scope                = azurerm_application_gateway.agw.0.id
  role_definition_name = "contributor"
  principal_id         = data.azurerm_user_assigned_identity.aks_agic_idenity.0.principal_id

}

# This bloc is the same to azurerm_role_assignment.agw_admin
#resource "azurerm_role_assignment" "agw_contributor2" {
#  count                = var.agic_enabled ? 1 : 0
#  scope                = azurerm_key_vault.project_keyvault.id
#  role_definition_name = "Key Vault Reader"
#  principal_id         = module.agw_keyvault[0].principal_id
#}

# Keyvault
resource "azurerm_role_assignment" "keyvault_admin" {
  count                = length([azuread_group.aks_administrators.id]) #length(var.admin_group_object_ids)
  scope                = azurerm_key_vault.project_keyvault.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = [azuread_group.aks_administrators.id][count.index] #var.admin_group_object_ids[count.index]
}

## Create Azure AD Group in Active Directory for AKS Admins (instead of hardcode it in dev.tf: see admin_group_object_ids=["159040da-e046-49f5-a7ab-a91a588d1eb1"])
resource "azuread_group" "aks_administrators" {
  display_name        = "${azurerm_resource_group.application.name}-cluster-administrators"
  mail_enabled     = true
  mail_nickname    = "${azurerm_resource_group.application.name}-group"
  security_enabled = true
  types            = ["Unified"]
  description         = "Azure AKS Kubernetes administrators for the ${azurerm_resource_group.application.name}-cluster."
}


resource "azurerm_role_assignment" "agw_admin" {
  count                = var.agic_enabled ? 1 : 0
  scope                = azurerm_key_vault.project_keyvault.id
  role_definition_name = "Key Vault Reader"
  principal_id         = module.agw_keyvault[0].principal_id
}


