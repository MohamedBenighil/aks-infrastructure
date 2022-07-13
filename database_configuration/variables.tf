#Project
variable "name" {
  type=string
  default="project name"
}

variable "location" {
  type=string
  default="project azure zone"
}

variable "environment" {
  type=string
  default="environment"
}
#Network
##Vnet bastion
variable admin_vnet_ip_address{
    type = string
    description = "vnet admin name"
}
variable admin_vnet_ip_address {
    type = string
    description = "vnet admin address space"
}
variable admin_subnet_name {
    type = string
    description = "subnet  admin name"
}

#PaaS
##ACR 
variable "acr_sku"     {
 type = string
 description = "Azure container sku"
 
}
