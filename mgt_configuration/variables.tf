#Project
variable "name" {
  type    = string
  default = "project name"
  validation {
    condition     = can(regex("^([a-z0-9\\-]{4,16})$", var.name))
    error_message = "Name could on only have alphanumeric character in lower case and hypens, string length should be betweeen 4 and 16 characters."
  }
}

variable "location" {
  type    = string
  default = "project azure zone"
}

variable "environment" {
  type    = string
  default = "environment"
  validation {
    condition     = contains(["prod", "dev", "qa", "stage", "test"], var.environment)
    error_message = "Valid value is one of the following: dev, prod,qa,stage,test."
  }
}

variable "tags" {
  type        = map(string)
  description = "list of azure tags"
}

variable "admin_group_object_ids" {
  type        = list(string)
  description = "A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster."
}
#Network
##Vnet bastion

variable "admin_vnet_ip_address" {
  type        = string
  description = "vnet admin address space"
}


variable "azurebastionsubnet_ip_address" {
  type        = string
  description = "subnet azure bastion address prefix"
}

variable "admin_ip_address" {
  type        = string
  description = "subnet admin address prefix"
}


variable "ssh_public_path" {
  type        = string
  description = "(Required) SSH public key pathused to authenticate to a virtual machine through ssh. the provided public key needs to be at least 2048-bit and in ssh-rsa format."
  sensitive   = true
}

variable "github_token_runner" {
  type        = string
  description = "github token to register agent"
  default     = null
}

