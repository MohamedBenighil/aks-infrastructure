locals {
  pip_name     = format("pip-bastion-%s", local.suffix_resource)
  bastion_name = format("bst-bastion-%s", local.suffix_resource)
}

resource "azurerm_virtual_network" "bastion" {
  name                = format("vnet-%s", azurerm_resource_group.bastion.name)
  address_space       = [var.admin_vnet_ip_address]
  location            = var.location
  resource_group_name = azurerm_resource_group.bastion.name
  tags                = var.tags
}

module "bastion_subnet" {
  source                    = "../modules/subnet"
  subnet_address_prefixes   = var.azurebastionsubnet_ip_address
  virtual_network           = azurerm_virtual_network.bastion
  identifier_name           = "AzureBastionSubnet"
  tags                      = var.tags
  disable_naming_convention = true
}

module "admin_subnet" {
  source                  = "../modules/subnet"
  subnet_address_prefixes = var.admin_ip_address
  virtual_network         = azurerm_virtual_network.bastion
  identifier_name         = "admin"
  tags                    = var.tags
}

resource "azurerm_public_ip" "bastion" {
  name                = local.pip_name
  location            = azurerm_resource_group.bastion.location
  resource_group_name = azurerm_resource_group.bastion.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  name                = local.bastion_name
  location            = azurerm_resource_group.bastion.location
  resource_group_name = azurerm_resource_group.bastion.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = module.bastion_subnet.private_subnet_id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}
