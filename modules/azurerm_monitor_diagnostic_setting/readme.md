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
| [azurerm_user_assigned_identity.identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | azure resource\_group | `any` | n/a | yes |
| <a name="input_resource_name"></a> [resource\_name](#input\_resource\_name) | recource name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | Client ID associated with the user assigned identity. |
| <a name="output_id"></a> [id](#output\_id) | The user assigned identity ID. |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | Service Principal ID associated with the user assigned identity. |
<!-- END_TF_DOCS -->