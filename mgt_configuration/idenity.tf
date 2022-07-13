
#principale aks identity
module "principal_vm_bastion" {
  source         = "../modules/identity"
  resource_name  = format("vm-principal-%s", local.suffix_resource)
  resource_group = azurerm_resource_group.bastion
}




