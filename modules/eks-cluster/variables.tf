variable "name_prefix" {
  description = "Prefix for the EKS cluster name"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

variable "cluster_role_arn" {
  description = "IAM role ARN used by the EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs used by the EKS control plane networking"
  type        = list(string)

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "At least two subnet IDs are required for EKS."
  }
}

variable "endpoint_public_access" {
  description = "Whether the EKS public API endpoint is enabled"
  type        = bool
  default     = true
}

variable "endpoint_private_access" {
  description = "Whether the EKS private API endpoint is enabled"
  type        = bool
  default     = false
}

variable "public_access_cidrs" {
  description = "CIDR blocks allowed to access the public EKS API endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  description = "Common tags applied to EKS resources"
  type        = map(string)
  default     = {}
}