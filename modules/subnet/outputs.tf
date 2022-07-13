output private_subnet_id {
    value = azurerm_subnet.subnet.id
}

output "private_virtual_network_id" {
  value =  var.virtual_network.id
}

output private_subnet_name {
    value = azurerm_subnet.subnet.name
}

output "private_ip_address" {
  value = azurerm_subnet.subnet.address_prefixes[0]
}
