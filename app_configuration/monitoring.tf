locals {
  log_name        = format("log-mbe-%s", local.suffix_resource)
  aks_ds_lag_name = format("ds-aks-%s", local.log_name)
  aks_default_logs = [
    {
      category              = "kube-audit-admin"
      retention_policy_days = 365
    },
    {
      category              = "guard"
      retention_policy_days = 365
    },
    {
      category              = "kube-scheduler"
      retention_policy_days = 365
    },
    {
      category              = "cluster-autoscaler"
      retention_policy_days = 365
    },
    {
      category              = "kube-apiserver"
      retention_policy_days = 365
    },
    {
      category              = "kube-controller-manager"
      retention_policy_days = 365
    },
    {
      category              = "cloud-controller-manager"
      retention_policy_days = 365
    },
    {
      category              = "csi-snapshot-controller"
      retention_policy_days = 365
    },
    {
      category              = "csi-azuredisk-controller"
      retention_policy_days = 365
      }, {
      category              = "csi-azurefile-controller"
      retention_policy_days = 365
    },
  ]
  awg_default_logs = [
    {
      category              = "ApplicationGatewayAccessLog"
      retention_policy_days = 365
    },
    {
      category              = "ApplicationGatewayAccessLog"
      retention_policy_days = 365
    },
    {
      category              = "ApplicationGatewayPerformanceLog"
      retention_policy_days = 365
    }
  ]
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = local.log_name
  location            = var.location
  resource_group_name = azurerm_resource_group.application.name
  #TODO:to be reviewed
  sku               = "PerGB2018"
  retention_in_days = 30
}

resource "azurerm_monitor_diagnostic_setting" "aks_diagnostic_setting" {
  name                       = local.aks_ds_lag_name
  target_resource_id         = azurerm_kubernetes_cluster.aks.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  dynamic "log" {
    for_each = local.aks_default_logs
    content {
      category = log.value.category
      enabled  = true
      retention_policy {
        enabled = true
        days    = log.value.retention_policy_days
      }
    }
  }

}



resource "azurerm_monitor_diagnostic_setting" "agw_diagnostic_setting" {
  count                      = var.agic_enabled ? 1 : 0
  name                       = local.aks_ds_lag_name
  target_resource_id         = azurerm_application_gateway.agw.0.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  dynamic "log" {
    for_each = local.awg_default_logs
    content {
      category = log.value.category
      enabled  = true
      retention_policy {
        enabled = true
        days    = log.value.retention_policy_days
      }
    }
  }

}
