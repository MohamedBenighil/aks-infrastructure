<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.2.3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =3.10.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.10.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acr_dns_zone"></a> [acr\_dns\_zone](#module\_acr\_dns\_zone) | ../modules/private_dns_zone | n/a |
| <a name="module_admin_subnet"></a> [admin\_subnet](#module\_admin\_subnet) | ../modules/subnet | n/a |
| <a name="module_aks_dns_zone"></a> [aks\_dns\_zone](#module\_aks\_dns\_zone) | ../modules/private_dns_zone | n/a |
| <a name="module_aks_node_subnet"></a> [aks\_node\_subnet](#module\_aks\_node\_subnet) | ../modules/subnet | n/a |
| <a name="module_aks_pod_subnet"></a> [aks\_pod\_subnet](#module\_aks\_pod\_subnet) | ../modules/subnet | n/a |
| <a name="module_gateway_subnet"></a> [gateway\_subnet](#module\_gateway\_subnet) | ../modules/subnet | n/a |
| <a name="module_keyvault_dns_zone"></a> [keyvault\_dns\_zone](#module\_keyvault\_dns\_zone) | ../modules/private_dns_zone | n/a |
| <a name="module_kubelet_aks"></a> [kubelet\_aks](#module\_kubelet\_aks) | ../modules/identity | n/a |
| <a name="module_paas_subnet"></a> [paas\_subnet](#module\_paas\_subnet) | ../modules/subnet | n/a |
| <a name="module_principal_aks"></a> [principal\_aks](#module\_principal\_aks) | ../modules/identity | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/container_registry) | resource |
| [azurerm_key_vault.project_keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/key_vault) | resource |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/kubernetes_cluster) | resource |
| [azurerm_log_analytics_workspace.law](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/log_analytics_workspace) | resource |
| [azurerm_resource_group.application](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.backend](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/resource_group) | resource |
| [azurerm_resource_group.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.aks_acr_pull](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.aks_dns_zone_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/role_assignment) | resource |
| [azurerm_virtual_network.application](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/virtual_network) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr_sku"></a> [acr\_sku](#input\_acr\_sku) | # ACR | `string` | n/a | yes |
| <a name="input_admin_group_object_ids"></a> [admin\_group\_object\_ids](#input\_admin\_group\_object\_ids) | A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster. | `list(string)` | n/a | yes |
| <a name="input_admin_vnet_ip_address"></a> [admin\_vnet\_ip\_address](#input\_admin\_vnet\_ip\_address) | vnet admin address space | `string` | n/a | yes |
| <a name="input_aks_auto_scaler_profile"></a> [aks\_auto\_scaler\_profile](#input\_aks\_auto\_scaler\_profile) | cluster auto scaler profile | `any` | <pre>{<br>  "balance_similar_node_groups": false,<br>  "empty_bulk_delete_max": 10,<br>  "expander": "random",<br>  "max_graceful_termination_sec": 600,<br>  "max_node_provisioning_time": "15m",<br>  "max_unready_nodes": 1,<br>  "max_unready_percentage": 45,<br>  "new_pod_scale_up_delay": "10s",<br>  "scale_down_delay_after_add": "10m",<br>  "scale_down_delay_after_delete": "scan_interval",<br>  "scale_down_delay_after_failure": "3m",<br>  "scale_down_unneeded": "10m",<br>  "scale_down_unready": "10m",<br>  "scale_down_utilization_threshold": "0.3",<br>  "scan_interval": "10s",<br>  "skip_nodes_with_local_storage": true,<br>  "skip_nodes_with_system_pods": true<br>}</pre> | no |
| <a name="input_aks_availability_zones"></a> [aks\_availability\_zones](#input\_aks\_availability\_zones) | value | `list(number)` | <pre>[<br>  1,<br>  2,<br>  3<br>]</pre> | no |
| <a name="input_aks_defautl_nodepool_name"></a> [aks\_defautl\_nodepool\_name](#input\_aks\_defautl\_nodepool\_name) | default agent pool name | `string` | `"agentpool"` | no |
| <a name="input_aks_node_max_count"></a> [aks\_node\_max\_count](#input\_aks\_node\_max\_count) | aks node max count | `string` | n/a | yes |
| <a name="input_aks_node_min_count"></a> [aks\_node\_min\_count](#input\_aks\_node\_min\_count) | aks node min count | `string` | n/a | yes |
| <a name="input_aks_node_size"></a> [aks\_node\_size](#input\_aks\_node\_size) | aks node size | `string` | n/a | yes |
| <a name="input_aks_version"></a> [aks\_version](#input\_aks\_version) | aks version | `string` | n/a | yes |
| <a name="input_app_aks_node_ip_address"></a> [app\_aks\_node\_ip\_address](#input\_app\_aks\_node\_ip\_address) | subnet  application aks node name | `string` | n/a | yes |
| <a name="input_app_aks_pod_ip_address"></a> [app\_aks\_pod\_ip\_address](#input\_app\_aks\_pod\_ip\_address) | subnet  application aks z name | `string` | n/a | yes |
| <a name="input_app_gateway_ip_address"></a> [app\_gateway\_ip\_address](#input\_app\_gateway\_ip\_address) | subnet  application azure application gateway name | `string` | n/a | yes |
| <a name="input_app_private_endpoint_ip_address"></a> [app\_private\_endpoint\_ip\_address](#input\_app\_private\_endpoint\_ip\_address) | subnet  application private endpoint name | `string` | n/a | yes |
| <a name="input_app_vnet_ip_address"></a> [app\_vnet\_ip\_address](#input\_app\_vnet\_ip\_address) | vnet application address space | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `"environment"` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"project azure zone"` | no |
| <a name="input_name"></a> [name](#input\_name) | Project | `string` | `"project name"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | list of azure tags | `map(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->