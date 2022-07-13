#Project
name ="kubota"
location = "northeurope"
environment="dev"
admin_group_object_ids=["159040da-e046-49f5-a7ab-a91a588d1eb1"]

tags ={
  test="kubota"
}
#Network
##Vnet bastion
admin_vnet_ip_address="10.0.4.0/26"
azurebastionsubnet_ip_address  = "10.0.4.0/27"
admin_ip_address = "10.0.4.32/27"

# Bastion 
ssh_public_path =  "./../env/key.pub"

