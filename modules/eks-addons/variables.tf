variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "addons" {
  description = "Map of EKS add-ons to install/manage"
  type = map(object({
    addon_version               = optional(string)
    resolve_conflicts_on_create = optional(string, "OVERWRITE")
    resolve_conflicts_on_update = optional(string, "OVERWRITE")
    service_account_role_arn    = optional(string)
  }))
  default = {}
}

variable "tags" {
  description = "Common tags applied to EKS add-ons"
  type        = map(string)
  default     = {}
}