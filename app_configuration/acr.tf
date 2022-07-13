locals {
  acr_name = replace(format("crmbe-%s", local.suffix_resource), "-", "")
}

resource "azurerm_container_registry" "acr" {
  name                = local.acr_name
  resource_group_name = azurerm_resource_group.application.name
  location            = var.location
  sku                 = var.acr_sku
  admin_enabled       = false
  tags                = var.tags
  dynamic "retention_policy" {
    for_each = var.acr_sku == "Premium" ? [""] : []
    content {
      days    = 7
      enabled = true
    }
  }

}


#Private endpoint
module "acr_private_endpoint" {
  count                  = var.acr_sku == "Premium" ? 1 : 0
  source                 = "./../modules/private_endpoint"
  subnet_virtual_network = module.paas_subnet
  name                   = local.acr_name
  azure_resource_group   = azurerm_resource_group.application
  tags                   = var.tags
  resource               = azurerm_container_registry.acr
  private_dns_zone       = data.azurerm_private_dns_zone.acr_dns_zone
  subresource_names      = ["registry"]
}
