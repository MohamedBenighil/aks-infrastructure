
variable "name" {
  type = string
  description = "recource name"
}

variable "resource_id" {
  type = sgtring
        description = "azure target resource id"
}


variable "law_id" {
  type = string
        description = "Log analytic workspace id"
}
variable "default_logs" {
  type=list(object({
    category  =string
    retention_policy_days  = number
  }))

  description = "list of category with retention period to capture"
}
