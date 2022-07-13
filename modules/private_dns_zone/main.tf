


resource "azurerm_private_dns_zone" "dnszone" {
  name                = var.domain
  resource_group_name = var.azure_resource_group.name
  tags = var.tags
}
