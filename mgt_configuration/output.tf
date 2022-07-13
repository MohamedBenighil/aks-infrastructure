output "cloud_init_file" {
  value     = azurerm_virtual_machine.main.os_profile.*.custom_data[0]
  sensitive = true
}
