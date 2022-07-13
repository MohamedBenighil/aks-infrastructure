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
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_delegation"></a> [delegation](#input\_delegation) | One or more delegation blocks as defined below. | <pre>list(object({<br>    name=string,<br>    service_delegation= object({<br>    name= string<br>    actions = list(string)<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_identifier_name"></a> [identifier\_name](#input\_identifier\_name) | identifier | `string` | n/a | yes |
| <a name="input_subnet_address_prefixes"></a> [subnet\_address\_prefixes](#input\_subnet\_address\_prefixes) | list of address prefixes | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | list of azure tags | `map(string)` | n/a | yes |
| <a name="input_virtual_network"></a> [virtual\_network](#input\_virtual\_network) | azure vnet | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_subnet_id"></a> [private\_subnet\_id](#output\_private\_subnet\_id) | n/a |
| <a name="output_private_virtual_network_id"></a> [private\_virtual\_network\_id](#output\_private\_virtual\_network\_id) | n/a |
<!-- END_TF_DOCS -->