<!-- BEGIN_TF_DOCS -->
## 1. Requirements

- terraform 1.2.3

<del>note: terrafom has to be configured to use remote backend</del> ==>  Done

## 2. Providers

- azurem 3.10.0 
- azuread 2.25.0
- cloudinit_config
 

<!-- END_TF_DOCS -->


##3.  configrations


There is 3 configuration block are available.
1. mgt_configuration, this block deploy:
- 2 resource group bastion and common
- common resource group host private dns zone
- bastion resource group host 1 vnet with 2 subnets, 1 azure bastion and 1 linux vm. the private ssh key is not stored to an azure keyvault( that could be an improvment)
2. app_configuration, this block deploy:
- 1 resource group
- 1 vnet with four subnet (aks node, aks pod, appliction gateway, PaaS/datastorage/privatendpoint)
- 1 aks
- 1 application gateway (agic brownfield)
- 3 azure identity ( aks, aks kubelet, application gateway)
- 1 keyvault
- log analytics
3. database_configuration, this block should be used to deployed database or storage
## 4. local deployment

#### 4.1 Requirements
Storage account for terraform states having the following infos :
```text
resource_group_name   : "terraform-states-rg"
storage_account_name  : "terraformstatekubota"
container_name        : "tfstatefiles"
```


#### 4.2 mgt

```shell
 cd ./infrastructure/mgt_configuration
 terraform init -backend-config=./../env/mgt-tfstate.tf
 terraform plan -var-file=./../env/mgt.tf
 terraform apply "mgt.plan" 
```
#### 4.3 apps

```shell
 cd ./infrastructure/app_configuration
 terraform init  -backend-config=./../env/dev-tfstate.tf
 terraform plan -var-file=./../env/mgt.tf -var-file=./../env/dev.tf 
 terraform apply dev.plan
```

## 5. Improvement/RAF
- rbac is not finished
- keyvault intergration with agic/aks is not finished  and integration with external-dns is not tested- 
- devops agent is not deployed in vm agent 
- tools are not deployed via cloud-init
- flux agent is not deployd 
- nsg is not configured
