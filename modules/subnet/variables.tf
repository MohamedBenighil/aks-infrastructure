variable "subnet_address_prefixes" {
  type = string
  description = "list of address prefixes"
}


variable "identifier_name" {
  type = string
  description = "identifier"
}

variable "disable_naming_convention" {
  type= bool
  description ="disable naming convention. use identifier_name for resource name"
  default = false
}

variable "virtual_network" {
  type = any
  description = "azure vnet"
}

variable "tags" {
  type=map(string)
 description = "list of azure tags"
}


variable "delegation" {
  type=list(object({
    name=string,
    service_delegation= object({
    name= string
    actions = list(string)
    })
  }))
  description = "One or more delegation blocks as defined below."
  default = []
}
