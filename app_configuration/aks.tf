locals {
  aks_name    = format("aks-%s", local.suffix_resource)
  aks_rg_name = format("%s-node", local.aks_name)
}
resource "azurerm_kubernetes_cluster" "aks" {

  name                              = local.aks_name
  location                          = var.location
  resource_group_name               = azurerm_resource_group.application.name
  dns_prefix_private_cluster        = local.aks_name
  private_cluster_enabled           = true
  private_dns_zone_id               = data.azurerm_private_dns_zone.aks_dns_zone.id
  node_resource_group               = local.aks_rg_name
  kubernetes_version                = var.aks_version
  role_based_access_control_enabled = true

  auto_scaler_profile {
    balance_similar_node_groups      = var.aks_auto_scaler_profile.balance_similar_node_groups
    expander                         = var.aks_auto_scaler_profile.expander
    max_graceful_termination_sec     = var.aks_auto_scaler_profile.max_graceful_termination_sec
    max_node_provisioning_time       = var.aks_auto_scaler_profile.max_node_provisioning_time
    max_unready_nodes                = var.aks_auto_scaler_profile.max_unready_nodes
    max_unready_percentage           = var.aks_auto_scaler_profile.max_unready_percentage
    new_pod_scale_up_delay           = var.aks_auto_scaler_profile.new_pod_scale_up_delay
    scale_down_delay_after_add       = var.aks_auto_scaler_profile.scale_down_delay_after_add
    scale_down_delay_after_delete    = var.aks_auto_scaler_profile.scale_down_delay_after_delete
    scale_down_delay_after_failure   = var.aks_auto_scaler_profile.scale_down_delay_after_failure
    scan_interval                    = var.aks_auto_scaler_profile.scan_interval
    scale_down_unneeded              = var.aks_auto_scaler_profile.scale_down_unneeded
    scale_down_unready               = var.aks_auto_scaler_profile.scale_down_unready
    scale_down_utilization_threshold = var.aks_auto_scaler_profile.scale_down_utilization_threshold
    empty_bulk_delete_max            = var.aks_auto_scaler_profile.empty_bulk_delete_max
    skip_nodes_with_local_storage    = var.aks_auto_scaler_profile.skip_nodes_with_local_storage
    skip_nodes_with_system_pods      = var.aks_auto_scaler_profile.skip_nodes_with_system_pods

  }
  #TODO: disk_encryption_set_id
  disk_encryption_set_id = null

  azure_active_directory_role_based_access_control {
    managed                = true
    admin_group_object_ids = var.admin_group_object_ids
  }


  default_node_pool {
    name                = var.aks_defautl_nodepool_name
    max_count           = var.aks_node_max_count
    min_count           = var.aks_node_min_count
    vm_size             = var.aks_node_size
    os_disk_size_gb     = 120
    enable_auto_scaling = true
    vnet_subnet_id      = module.aks_node_subnet.private_subnet_id
    pod_subnet_id       = module.aks_pod_subnet.private_subnet_id
    zones               = var.aks_availability_zones
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }

  kubelet_identity {
    user_assigned_identity_id = module.kubelet_aks.id
    client_id                 = module.kubelet_aks.client_id
    object_id                 = module.kubelet_aks.principal_id
  }

  identity {
    type = "UserAssigned"
    identity_ids = [
      module.principal_aks.id
    ]
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = false

  }
  #outbound_type ="loadBalancer"
  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
  }

  azure_policy_enabled = true



  dynamic "ingress_application_gateway" {
    for_each = var.agic_enabled == true ? [""] : []
    content {
      gateway_id = azurerm_application_gateway.agw.0.id
    }
  }


  tags = var.tags
  depends_on = [
    azurerm_role_assignment.aks_kubelet_owner_contributor
  ]
}

