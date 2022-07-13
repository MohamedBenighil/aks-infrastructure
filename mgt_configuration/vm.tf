locals {
  vm_name      = format("vmmbe-l-%s", local.suffix_resource)
  vm_nic_name  = format("nic-%s", local.vm_name)
  ssh_key_name = format("ssh-key-%s", local.vm_name)

}

resource "azurerm_ssh_public_key" "ssh_key" {
  name                = local.ssh_key_name
  resource_group_name = azurerm_resource_group.bastion.name
  location            = azurerm_resource_group.bastion.location
  public_key          = file(var.ssh_public_path)
}

resource "azurerm_network_interface" "main" {
  name                = local.vm_nic_name
  location            = azurerm_resource_group.bastion.location
  resource_group_name = azurerm_resource_group.bastion.name

  ip_configuration {
    name                          = "default"
    subnet_id                     = module.admin_subnet.private_subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address_version    = "IPv4"
    private_ip_address            = cidrhost(module.admin_subnet.private_ip_address, 5)
  }
}
resource "azurerm_virtual_machine" "main" {

  name                  = local.vm_name
  location              = azurerm_resource_group.bastion.location
  resource_group_name   = azurerm_resource_group.bastion.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_D2as_v4" # it was "Standard_B2ms", which is not available for my subsribtion

  identity {
    type         = "UserAssigned"
    identity_ids = [module.principal_vm_bastion.id]
  }

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = azurerm_ssh_public_key.ssh_key.public_key
      path     = "/home/rootvm/.ssh/authorized_keys"
    }
  }


  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
  storage_os_disk {
    name              = format("osdisk-%s", local.vm_name)
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = local.vm_name
    admin_username = "rootvm"
    custom_data    = data.template_cloudinit_config.config.rendered
  }
  boot_diagnostics {
    enabled     = true
    storage_uri = azurerm_storage_account.bootdiagnostic.primary_blob_endpoint
  }
  tags = var.tags
}

resource "azurerm_storage_account" "bootdiagnostic" {
  name                     = replace(format("stmbe-%s", local.vm_name), "-", "")
  location                 = azurerm_resource_group.bastion.location
  resource_group_name      = azurerm_resource_group.bastion.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

data "template_file" "cloudinit" {
  template = file("${path.module}/cloudinit.tpl")

  vars = {
    github_token = "${var.github_token_runner}"
  }
}

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = data.template_file.cloudinit.rendered
  }
}
