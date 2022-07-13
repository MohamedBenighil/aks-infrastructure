locals {
    ds_log_name = format("ds-%s", var.name)
}


resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  name                       = local.ds_log_name
  target_resource_id         = var.resource_id
  log_analytics_workspace_id = var.law_id

  dynamic "log" {
    for_each = var.default_logs
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
