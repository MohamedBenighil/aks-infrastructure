#Project
name ="kubota"
location = "northeurope"
environment="dev"
#admin_group_object_ids=["159040da-e046-49f5-a7ab-a91a588d1eb1"] <== it it not handy to hardcod it. 
                                                                   # I relpaced it by adding azuread provider (see main.tf), 
                                                                   # then i created azuread_group ressource  (see rbac.tf)

tags ={
  test="kubota"
}
#Network
##Vnet bastion
admin_vnet_ip_address="10.0.4.0/26"
azurebastionsubnet_ip_address  = "10.0.4.0/27"
admin_ip_address = "10.0.4.32/27"

#VNET Application
app_vnet_ip_address="10.1.0.0/22"
app_aks_node_ip_address="10.1.2.0/26"
app_aks_pod_ip_address="10.1.0.0/23"
app_gateway_ip_address="10.1.2.64/27"

app_private_endpoint_ip_address="10.1.2.96/27"

#AKS
aks_node_size="standard_d2as_v4"

aks_node_max_count=3
aks_node_min_count=1


aks_version= "1.22.6"
## ACR
acr_sku = "Standard"


## Application gateway
azure_application_gateway_capacity=1
