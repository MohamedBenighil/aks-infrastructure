<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_private_dns_zone_virtual_network_link.dns_zone_vnet_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.pe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_resource_group"></a> [azure\_resource\_group](#input\_azure\_resource\_group) | azure resource group name | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | privat endpoint name | `string` | n/a | yes |
| <a name="input_private_dns_zone"></a> [private\_dns\_zone](#input\_private\_dns\_zone) | private dns zone resource | `any` | n/a | yes |
| <a name="input_resource"></a> [resource](#input\_resource) | azure resource | `any` | n/a | yes |
| <a name="input_subnet_virtual_network"></a> [subnet\_virtual\_network](#input\_subnet\_virtual\_network) | azure subnet | `any` | n/a | yes |
| <a name="input_subresource_names"></a> [subresource\_names](#input\_subresource\_names) | A list of subresource names which the Private Endpoint is able to connect to. subresource\_names corresponds to group\_id. Changing this forces a new resource to be created. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | list of azure tags | `map(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->