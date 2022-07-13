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


###############
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
###############
##Vnet application
variable "app_vnet_ip_address" {
  type        = string
  description = "vnet application address space"
}
variable "app_aks_node_ip_address" {
  type        = string
  description = "subnet  application aks node name"
}
variable "app_aks_pod_ip_address" {
  type        = string
  description = "subnet  application aks z name"
}
variable "app_gateway_ip_address" {
  type        = string
  description = "subnet  application azure application gateway name"
}

variable "app_private_endpoint_ip_address" {
  type        = string
  description = "subnet  application private endpoint name"
}

#AKS
variable "aks_node_size" {
  type        = string
  description = "aks node size"
}

variable "aks_node_max_count" {
  type        = string
  description = "aks node max count"
}

variable "aks_node_min_count" {
  type        = string
  description = "aks node min count"
}

variable "aks_defautl_nodepool_name" {
  type        = string
  default     = "agentpool"
  description = "default agent pool name"
}

variable "aks_version" {
  type        = string
  description = "aks version"
}

variable "aks_auto_scaler_profile" {
  type        = any
  description = "cluster auto scaler profile"
  default = {
    balance_similar_node_groups      = false
    expander                         = "random"
    max_graceful_termination_sec     = 600
    max_node_provisioning_time       = "15m"
    max_unready_nodes                = 1
    max_unready_percentage           = 45
    new_pod_scale_up_delay           = "10s"
    scale_down_delay_after_add       = "10m"
    scale_down_delay_after_delete    = "10s"
    scale_down_delay_after_failure   = "3m"
    scan_interval                    = "10s"
    scale_down_unneeded              = "10m"
    scale_down_unready               = "10m"
    scale_down_utilization_threshold = "0.3"
    empty_bulk_delete_max            = 10
    skip_nodes_with_local_storage    = true
    skip_nodes_with_system_pods      = true
  }
}
variable "aks_availability_zones" {
  type        = list(number)
  default     = [1, 2, 3]
  description = "value"

}
## ACR
variable "acr_sku" {
  type        = string
  description = "(Required) The SKU name of the container registry. Possible values are Basic, Standard and Premium."
}


## Application gateway
variable "azure_application_gateway_capacity" {
  type        = number
  description = "The Capacity of the SKU to use for this Application Gateway. When using a V1 SKU this value must be between 1 and 32, and 1 to 125 for a V2 SKU. This property is optional if autoscale_configuration is set."
}

variable "agic_enabled" {
  type        = bool
  description = "enable agic addon in brownfield"
  default     = true
}
