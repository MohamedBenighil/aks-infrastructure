
variable "azure_resource_group" {
  type = any
  description = "azure resource group name"
}

variable "name" {
  type = string
  description = "privat endpoint name"
}

variable "private_virtual_network_id" {
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


