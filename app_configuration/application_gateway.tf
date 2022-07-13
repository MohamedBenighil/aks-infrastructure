locals {
  agw_name                  = format("agw-%s", local.suffix_resource)
  pip_name                  = format("pip-%s", local.suffix_resource)
  feip_name                 = format("feip-%s", local.suffix_resource)
  gic_name                  = format("gic-%s", local.suffix_resource)
  http_setting_name         = format("be-htst-%s", local.suffix_resource)
  frontend_port_name        = format("feport-%s", local.suffix_resource)
  request_routing_rule_name = format("rqrt-%s", local.suffix_resource)
  backend_address_pool_name = format("rqrt-%s", local.suffix_resource)
  listener_name             = format("rqrt-%s", local.suffix_resource)

}


resource "azurerm_public_ip" "pip" {
  count               = var.agic_enabled ? 1 : 0
  name                = local.pip_name
  resource_group_name = azurerm_resource_group.application.name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"

}

resource "azurerm_application_gateway" "agw" {
  count               = var.agic_enabled ? 1 : 0
  name                = local.agw_name
  resource_group_name = azurerm_resource_group.application.name
  location            = var.location

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = var.azure_application_gateway_capacity
  }

  frontend_ip_configuration {
    name                 = local.feip_name
    public_ip_address_id = azurerm_public_ip.pip[0].id
  }


  gateway_ip_configuration {
    name      = local.gic_name
    subnet_id = module.gateway_subnet.private_subnet_id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  identity {
    type = "UserAssigned"
    identity_ids = [
      module.agw_keyvault[0].id
    ]
  }
  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.feip_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
    priority                   = 10
  }
}


