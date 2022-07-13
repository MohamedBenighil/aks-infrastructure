
variable "azure_resource_group" {
  type = any
  description = "azure resource group name"
}

variable "domain" {
  type = string
  description = "domain name"
}



variable "tags" {
  type=map(string)
  description = "list of azure tags"
}
