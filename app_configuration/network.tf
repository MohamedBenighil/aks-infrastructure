#VNET
locals {
  nsg_prefix = format("nsg-%s", local.suffix_resource)
}

data "azurerm_virtual_network" "admin" {
  name                = format("vnet-%s-bastion-rg", var.name)
  resource_group_name = format("%s-bastion-rg", var.name)
}

resource "azurerm_virtual_network" "application" {
  name                = format("vnet-%s", azurerm_resource_group.application.name)
  address_space       = [var.app_vnet_ip_address]
  location            = var.location
  resource_group_name = azurerm_resource_group.application.name
  tags                = var.tags
}

#Peering
resource "azurerm_virtual_network_peering" "peer_bastion_application" {
  name                         = format("peer-vnet-admin-with-app-%s", var.environment)
  resource_group_name          = azurerm_resource_group.application.name
  virtual_network_name         = azurerm_virtual_network.application.name
  remote_virtual_network_id    = data.azurerm_virtual_network.admin.id
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "peer_application_bastion" {
  name                         = format("peer-vnet-app-%s-with-admin", var.environment)
  resource_group_name          = data.azurerm_virtual_network.admin.resource_group_name
  virtual_network_name         = data.azurerm_virtual_network.admin.name
  remote_virtual_network_id    = azurerm_virtual_network.application.id
  allow_virtual_network_access = true
}
#SUBNET



module "aks_node_subnet" {
  source                  = "../modules/subnet"
  subnet_address_prefixes = var.app_aks_node_ip_address
  virtual_network         = azurerm_virtual_network.application
  identifier_name         = "aks-node"
  tags                    = var.tags
}
module "aks_pod_subnet" {
  source                  = "../modules/subnet"
  subnet_address_prefixes = var.app_aks_pod_ip_address
  virtual_network         = azurerm_virtual_network.application
  identifier_name         = "aks-pod"
  tags                    = var.tags
  delegation = [{
    name = "pod_delegation"
    service_delegation = {
      name    = "Microsoft.ContainerService/managedClusters"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
    }
  ]
}

module "gateway_subnet" {
  source                  = "../modules/subnet"
  subnet_address_prefixes = var.app_gateway_ip_address
  virtual_network         = azurerm_virtual_network.application
  identifier_name         = "gateway"
  tags                    = var.tags
}
module "paas_subnet" {
  source                  = "../modules/subnet"
  subnet_address_prefixes = var.app_private_endpoint_ip_address
  virtual_network         = azurerm_virtual_network.application
  identifier_name         = "paas"
  tags                    = var.tags
}

#NSG

resource "azurerm_network_security_group" "nsg_gateway" {
  name                = format("nsg-%s", module.gateway_subnet.private_subnet_name)
  #location            = azurerm_resource_group.example.location
  #resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.application.location
  resource_group_name = azurerm_resource_group.application.name

}

resource "azurerm_network_security_rule" "apw_rule_1" {
  name                        = format("Inbound allow health monitorung")
  network_security_group_name = azurerm_network_security_group.nsg_gateway.name
  resource_group_name         = azurerm_resource_group.application.name

  priority                   = 100
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "65503-65534"
  source_address_prefix      = "Internet"
  destination_address_prefix = "*"
  description                = "Allow WAG health monitoring from internet to public WAF subnet"

}
resource "azurerm_network_security_rule" "apw_rule_2" {
  name                        = format("Inbound Azure lb")
  network_security_group_name = azurerm_network_security_group.nsg_gateway.name
  resource_group_name         = azurerm_resource_group.application.name

  priority                   = 4000
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "*"
  source_address_prefix      = "AzureLoadBalancer"
  destination_address_prefix = "*"
  description                = "Allow probe from Azure Load Balancer to the waf subnet"

}
resource "azurerm_network_security_rule" "apw_rule_deny" {
  name                        = "Inbound deny all"
  network_security_group_name = azurerm_network_security_group.nsg_gateway.name
  resource_group_name         = azurerm_resource_group.application.name

  priority                   = 4096
  direction                  = "Inbound"
  access                     = "Deny"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "*"
  source_address_prefix      = "*"
  destination_address_prefix = "*"

}
