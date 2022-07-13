
variable "azure_resource_group" {
  type = any
  description = "azure resource group name"
}

variable "name" {
  type = string
  description = "privat endpoint name"
}

variable "subnet_virtual_network" {
  type = any
  description = "azure subnet"
}

variable "tags" {
  type=map(string)
 description = "list of azure tags"
}

variable "private_dns_zone" {
  type=any
  description = "private dns zone resource"
}

variable "resource" {
  type=any
  description = "azure resource"
}

variable "subresource_names" {
  description="A list of subresource names which the Private Endpoint is able to connect to. subresource_names corresponds to group_id. Changing this forces a new resource to be created."
  type = list(string)
}
