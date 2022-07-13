output private_dns_zone_id {
    value = azurerm_private_dns_zone.dnszone.id
}


output "name" {
 value =  azurerm_private_dns_zone.dnszone.name
}
