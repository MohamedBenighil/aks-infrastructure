locals {
  keyvault_name = format("kvmbe-%s", local.suffix_resource)
}

resource "azurerm_key_vault" "project_keyvault" {
  name                        = local.keyvault_name
  location                    = var.location
  resource_group_name         = azurerm_resource_group.application.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}

#Private endpoint
module "keyvault_private_endpoint" {
  source                 = "./../modules/private_endpoint"
  subnet_virtual_network = module.paas_subnet
  name                   = local.keyvault_name
  azure_resource_group   = azurerm_resource_group.application
  tags                   = var.tags
  resource               = azurerm_key_vault.project_keyvault
  private_dns_zone       = data.azurerm_private_dns_zone.keyvault_dns_zone
  subresource_names      = ["vault"]
}
